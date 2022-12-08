import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:installment_calculator/core/utils/resources/color_styles.dart';
import 'package:installment_calculator/core/utils/resources/text_styles.dart';
import 'package:installment_calculator/features/form/form_screen.dart';
import 'package:installment_calculator/features/sign_up/sign_up_cubit.dart';
import 'package:installment_calculator/features/sign_up/sign_up_states.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = SignUpCubit.get(context);
    return BlocConsumer<SignUpCubit,SignUpStates>(
      listener: (context,state){
        if(state is GoogleSignInSuccessState || state is FaceBookSignInSuccessState){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => FormScreen(),
            ),
                (route) {
              return false;
            },
          );
        }
      },
      builder: (context,state) {
        return Scaffold(
            body: SafeArea(
              child: Center(
                /// background image
                child: Container(
                  constraints: const BoxConstraints.expand(),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          SizedBox(height: 80.w,),
                          const Image(image: AssetImage('assets/images/logo.png'),),
                          SizedBox(height: 20.w,),
                          Text(
                            'Welcome to Installment Calculator \nPlease, sign up to get our services',
                            style: CustomTextStyle.h6Regular(context).copyWith(
                              color: ColorStyle.baseWhite,
                            ),
                          ),
                          SizedBox(height: 80.w,),
                          if(state is GoogleSignInLoadingState || state is FaceBookSignInLoadingState)
                            SizedBox(
                              width: 100.w,
                              height: 100.w,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: ColorStyle.baseWhite,
                                ),
                              ),
                            ),
                          if(state is GoogleSignInLoadingState!=true && state is FaceBookSignInLoadingState!=true)
                            Column(
                            children: [
                              /// Google Sign In Button
                              Center(
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorStyle.baseWhite,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: ColorStyle.caption,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 10.h,
                                    ),
                                    fixedSize: Size(300.w, 50.w),
                                  ),
                                  icon: const FaIcon(FontAwesomeIcons.google,color: ColorStyle.red),
                                  label: Text('Sign Up With Google',
                                    style: CustomTextStyle.h6Regular(context).copyWith(
                                      color: ColorStyle.baseBlack,
                                    ),
                                  ),
                                  onPressed: (){
                                    cubit.signInWithGoogle().then((value) {
                                      if(value!=null){
                                        cubit.createUser(id:value.user.uid);
                                      }
                                    }
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 20.w,),
                              /// Facebook Sign In Button
                              Center(
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorStyle.mainColor,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: ColorStyle.mainColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 10.h,
                                    ),
                                    fixedSize: Size(300.w, 50.w),
                                  ),
                                  icon: const FaIcon(FontAwesomeIcons.facebookF,color: ColorStyle.baseWhite),
                                  label: Text('Sign Up With Facebook',
                                    style: CustomTextStyle.h6Regular(context).copyWith(
                                      color: ColorStyle.baseWhite,
                                    ),
                                  ),
                                  onPressed: (){
                                    cubit.signInWithFacebook().then((value) {
                                      if(value!=null) {
                                        cubit.createUser(id:value.user.uid);
                                      }
                                    }
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
      }
    );
  }
}