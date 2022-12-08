import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:installment_calculator/core/network/local/cache_helper.dart';
import 'package:installment_calculator/core/utils/resources/color_styles.dart';
import 'package:installment_calculator/core/utils/resources/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:installment_calculator/core/utils/widgets/captcha.dart';
import 'package:installment_calculator/core/utils/widgets/drop_down.dart';
import 'package:installment_calculator/core/utils/widgets/main_btn.dart';
import 'package:installment_calculator/core/utils/widgets/main_text_field.dart';
import 'package:installment_calculator/core/utils/widgets/radio_btn.dart';
import 'package:installment_calculator/features/form/form_cubit.dart';
import 'package:installment_calculator/features/form/form_states.dart';
import 'package:installment_calculator/features/home/home_screen.dart';


class FormScreen extends StatefulWidget {
  FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  List<String> governorate = [
    'Select Governorate',
    'Cairo',
    'Giza',
    'Alexandria',
    'Al Beheira',
    'Al Daqahliya',
    'Al Fayoum',
    'Al Gharbia',
    'Al Meniya',
    'Al Monufia',
    'Al Sharqia',
    'Aswan',
    'Asyut',
    'Bani Souaif',
    'Damietta',
    'Ismailia',
    'Kafr El Sheikh',
    'Luxor',
    'Matrooh',
    'New Valley',
    'Port Said',
    'Qalyubia',
    'Qena',
    'Red Sea',
    'Sohag',
    'Suez',
    'North Sinai',
    'South Sinai',
  ];
  String currentGovernorate = 'Select Governorate';
  List<String> income = [
    'Please Choose',
    'Less than 5000',
    '5000 - 10000',
    '10000 - 15000',
    '15000 - 20000',
    '20000 - 25000',
    'more than 25000',
  ];
  String currentIncome = 'Please Choose';
  List<String> aboutUs = [
    'Please Choose',
    'Facebook',
    'Instagram',
    'Twitter',
    'linkedIn',
    'other',
  ];
  String currentAboutUs = 'Please Choose';
  var nameController = TextEditingController();
  var mobileController = TextEditingController();
  var companyController = TextEditingController();
  var emailController = TextEditingController();
  var captchaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormCubit,FormStates>(
      listener: (context, state) {
        if(state is UploadFormSuccessState){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
                (route) {
              return false;
            },
          );
        }
      },
      builder: (context,state){
      var cubit = FormCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Apply Now'),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ADIB is here to service you 24 hours a day, please select the way  you want us to  assist you and our personal will be glad to help you out with any query/questions.',
                        style: CustomTextStyle.h6Regular(context).copyWith(
                          color: ColorStyle.baseBlack,
                        ),
                      ),
                      SizedBox(
                        height: 30.w,
                      ),

                      ///name
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: 'Name',
                                  style: CustomTextStyle.h6Regular(context).copyWith(
                                    color: ColorStyle.baseBlack,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' * ',
                                      style:
                                          CustomTextStyle.h6Regular(context).copyWith(
                                        color: ColorStyle.baseBlack,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          Expanded(
                            child: MainTextField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'required';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),

                      ///Governorate
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: 'Governorate',
                                  style: CustomTextStyle.h6Regular(context).copyWith(
                                    color: ColorStyle.baseBlack,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' * ',
                                      style:
                                          CustomTextStyle.h6Regular(context).copyWith(
                                        color: ColorStyle.baseBlack,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          Expanded(
                            child: DropDown(
                                items: governorate,
                                value: currentGovernorate,
                                onChanged: (value) {
                                  setState(() {
                                    currentGovernorate = value!;
                                  });
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),

                      ///mobile
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: 'Mobile',
                                  style: CustomTextStyle.h6Regular(context).copyWith(
                                    color: ColorStyle.baseBlack,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' * ',
                                      style:
                                          CustomTextStyle.h6Regular(context).copyWith(
                                        color: ColorStyle.baseBlack,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          Expanded(
                            child: MainTextField(
                              controller: mobileController,
                              keyboardType: TextInputType.phone,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'required';
                                }else if(value.length != 11){
                                  return 'wrong mobile number';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),

                      ///Employed/Self Employed
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: 'Employed/Self Employed',
                                  style: CustomTextStyle.h6Regular(context).copyWith(
                                    color: ColorStyle.baseBlack,
                                  ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: RadioBtn(
                              data: cubit.employed,
                              radioName: cubit.employedValue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 14.w,
                      ),

                      ///banking obligation
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: 'Do you have any banking obligation(Personal Loan - CarLoan - Credit Card)?',
                                  style: CustomTextStyle.h6Regular(context).copyWith(
                                    color: ColorStyle.baseBlack,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' * ',
                                      style:
                                      CustomTextStyle.h6Regular(context).copyWith(
                                        color: ColorStyle.baseBlack,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          Expanded(
                            child: RadioBtn(
                              data: cubit.obligation,
                              radioName: cubit.obligationValue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),

                      ///bank customer
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: 'Are you an ADIB Customer?',
                                  style: CustomTextStyle.h6Regular(context).copyWith(
                                    color: ColorStyle.baseBlack,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' * ',
                                      style:
                                      CustomTextStyle.h6Regular(context).copyWith(
                                        color: ColorStyle.baseBlack,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          Expanded(
                            child: RadioBtn(
                              data: cubit.adibCustomer,
                              radioName: cubit.adibCustomerValue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),

                      ///company
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: 'Company',
                                  style: CustomTextStyle.h6Regular(context).copyWith(
                                    color: ColorStyle.baseBlack,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' * ',
                                      style:
                                      CustomTextStyle.h6Regular(context).copyWith(
                                        color: ColorStyle.baseBlack,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          Expanded(
                            child: MainTextField(
                              controller: companyController,
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'required';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),

                      ///monthly income
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: 'Monthly Income',
                                  style: CustomTextStyle.h6Regular(context).copyWith(
                                    color: ColorStyle.baseBlack,
                                  ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: DropDown(
                                items: income,
                                value: currentIncome,
                                onChanged: (value) {
                                  setState(() {
                                    currentIncome = value!;
                                  });
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),

                      ///email
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: 'Email',
                                  style: CustomTextStyle.h6Regular(context).copyWith(
                                    color: ColorStyle.baseBlack,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' * ',
                                      style:
                                      CustomTextStyle.h6Regular(context).copyWith(
                                        color: ColorStyle.baseBlack,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          Expanded(
                            child: MainTextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'required';
                                }else if(!value.contains('@')){
                                  return 'wrong email';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),

                      ///here about us
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: 'Where did you hear about us?',
                                  style: CustomTextStyle.h6Regular(context).copyWith(
                                    color: ColorStyle.baseBlack,
                                  ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: DropDown(
                                items: aboutUs,
                                value: currentAboutUs,
                                onChanged: (value) {
                                  setState(() {
                                    currentAboutUs = value!;
                                  });
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.w,
                      ),

                      ///captcha
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: 'Captcha',
                                style: CustomTextStyle.h6Regular(context).copyWith(
                                  color: ColorStyle.baseBlack,
                                ),
                                  children: [
                                    TextSpan(
                                      text: ' * ',
                                      style:
                                      CustomTextStyle.h6Regular(context).copyWith(
                                        color: ColorStyle.baseBlack,
                                      ),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Captcha(
                                  cap: cubit.capElement ?? cubit.capList[0],
                                ),
                                SizedBox(
                                  height: 5.w,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: MainTextField(
                                        controller: captchaController,
                                        keyboardType: TextInputType.text,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'required';
                                          }else if(cubit.capElement == null){
                                            cubit.capElement = cubit.capList[0];
                                          }else if(value != cubit.capElement!.text){
                                            return 'wrong captcha';
                                          }else{
                                            setState(() {
                                              captchaController.text = 'verified';
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Icons.refresh,
                                        color: ColorStyle.baseBlack,
                                        size: 26.w,
                                      ),
                                      onPressed: () {
                                          cubit.changeCaptcha();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.w,
                      ),

                      ///Send
                      Center(
                        child: MainBtn(
                          text: 'Calculate',
                          onPressed: (){
                            if (_formKey.currentState!.validate()) {
                              cubit.uploadForm(
                                id: CacheHelper.getData(key: 'uId'),
                                name: nameController.text,
                                governorate: currentGovernorate,
                                mobile: mobileController.text,
                                employed: CacheHelper.getData(key: 'employed')??'',
                                obligation: CacheHelper.getData(key: 'obligation')??'',
                                adibCustomer: CacheHelper.getData(key: 'adibCustomer')??'',
                                company: companyController.text,
                                income: currentIncome,
                                email: emailController.text,
                                aboutUs: currentAboutUs,
                                captcha: 'verified',
                              );
                            }
                          },
                          color:ColorStyle.caption,
                          height: 20.w,
                        ),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),


                      if(cubit.alert.isNotEmpty)
                      RichText(
                        text: TextSpan(
                            text: '(*)',
                            style: CustomTextStyle.h6Regular(context).copyWith(
                              color: ColorStyle.darkTextError,
                            ),
                            children: [
                              TextSpan(
                                text: ' These fields are mandatory to be filled',
                                style:
                                CustomTextStyle.h6Regular(context).copyWith(
                                  color: ColorStyle.darkTextError,
                                ),
                              ),
                            ]),
                      ),
                    ],
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


