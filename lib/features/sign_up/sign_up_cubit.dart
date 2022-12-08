import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:installment_calculator/core/network/local/cache_helper.dart';
import 'package:installment_calculator/features/sign_up/sign_up_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class SignUpCubit extends Cubit<SignUpStates>{
  SignUpCubit() : super(InitialSignUpScreenStates());

  static SignUpCubit get(context) => BlocProvider.of(context);

  /// Google Sign In
  Future signInWithGoogle() async {
    emit(GoogleSignInLoadingState());
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      emit(GoogleSignInSuccessState());
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    catch(e){
      emit(GoogleSignInErrorState());
    }
  }

  /// Facebook Sign In
  Future signInWithFacebook() async {
    emit(FaceBookSignInLoadingState());
    try{
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);
      emit(FaceBookSignInSuccessState());
      return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    }
    catch(e){
      emit(FaceBookSignInErrorState());
    }
  }


  /// create new user
  void createUser({
    required String id,
  }) async {
    emit(CreateUserLoadingState());
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .set({'id':id});
      CacheHelper.saveData(key: 'uId', value: id);
      emit(CreateUserSuccessState());
    }
    catch(e){
      emit(CreateUserErrorState());
    }
  }

}