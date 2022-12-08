import 'package:equations/equations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:installment_calculator/core/network/local/cache_helper.dart';
import 'package:installment_calculator/features/home/home_states.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  String alertText='';
  String result= '';
  void calculateInstallments({
    /// finance value
    required String p,
    /// tenor in years.
    required int n,
    required String unitType,
    required int age,
  }) {
    if(unitType.isEmpty || p.isEmpty){
      result='';
      alertText= 'All data contains(*) Required';
      emit(CalculateInstallmentsError());
    }else if (age + (n/12) > 65){
      result='';
      alertText= 'Your age plus tenor period must not exceed 65 years';
      emit(CalculateInstallmentsError());
    }else if(double.parse(p) < 100000){
      result='';
      alertText= 'Finance value must be greater than 100,000';
      emit(CalculateInstallmentsError());
    }else{
      String i = (0.05/12).toStringAsFixed(5);
      result = (const ExpressionParser().evaluate('$p*($i*(1+$i)^$n)/((1+$i)^$n-1)')).toStringAsFixed(2);
      alertText= 'Terms and conditions apply';
      emit(CalculateInstallmentsSuccess());
    }

  }



  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.clear();
      emit(LogOutSuccess());
    });
  }

}