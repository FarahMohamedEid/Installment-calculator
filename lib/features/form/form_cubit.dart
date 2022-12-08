import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:installment_calculator/core/network/local/cache_helper.dart';
import 'package:installment_calculator/core/utils/widgets/captcha.dart';
import 'package:installment_calculator/core/utils/widgets/radio_btn.dart';
import 'package:installment_calculator/features/form/form_states.dart';

class FormCubit extends Cubit<FormStates> {
  FormCubit() : super(InitialFormScreenStates());

  static FormCubit get(context) => BlocProvider.of(context);

  List<RadioModel> adibCustomer = [
  RadioModel(text: 'Yes',isSelected: false),
  RadioModel(text: 'No',isSelected: false),
  ];
   String adibCustomerValue = 'adibCustomer';

  List<RadioModel> obligation =  [
    RadioModel(text: 'Yes',isSelected: false),
    RadioModel(text: 'No',isSelected: false),
  ];
  String obligationValue = 'obligation';

  List<RadioModel> employed =  [
    RadioModel(text: 'Employed',isSelected: false),
    RadioModel(text: 'Self Employed',isSelected: false),
  ];
  String employedValue = 'employed';

  List<CapModel> capList = [
    CapModel(imgPath: 'cap1.png', text: 'kwbkc'),
    CapModel(imgPath: 'cap4.png', text: 'B1A4'),
    CapModel(imgPath: 'cap5.png', text: 'W68HP'),
    CapModel(imgPath: 'cap6.png', text: 'smwm'),
  ];
  CapModel? capElement ;
  void changeCaptcha(){
    capElement = capList[Random().nextInt(capList.length)];
    emit(ChangeCaptchaStates());
  }

  String alert = '';
  void uploadForm({
    required String id,
    required String name,
    required String governorate,
    required String mobile,
    required String employed,
    required String obligation,
    required String adibCustomer,
    required String company,
    required String income,
    required String email,
    required String aboutUs,
    required String captcha,
  }) async {
    emit(UploadFormLoadingState());
    if(governorate == 'Select Governorate' || obligation.isEmpty || adibCustomer.isEmpty) {
      alert = 'All data contains(*) Required';
      emit(UploadFormErrorState());
    }else{
      try {
        FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .set({
              'id':id,
              'name':name,
              'governorate':governorate,
              'mobile':mobile,
              'employed':employed,
              'obligation':obligation,
              'adibCustomer':adibCustomer,
              'company':company,
              'income':income,
              'email':email,
              'aboutUs':aboutUs,
              'captcha':captcha,
            });
        CacheHelper.saveData(key: 'form', value: true);
        emit(UploadFormSuccessState());
      }
      catch(e){
        emit(UploadFormErrorState());
      }
    }

  }
}