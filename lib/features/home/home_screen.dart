import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:installment_calculator/core/utils/resources/color_styles.dart';
import 'package:installment_calculator/core/utils/widgets/drop_down.dart';
import 'package:installment_calculator/core/utils/widgets/main_btn.dart';
import 'package:installment_calculator/core/utils/widgets/main_text_field.dart';
import 'package:installment_calculator/core/utils/widgets/radio_btn.dart';
import 'package:installment_calculator/features/home/home_cubit.dart';
import 'package:installment_calculator/features/home/home_states.dart';
import 'package:installment_calculator/features/sign_up/sign_up_screen.dart';
import '../../core/utils/resources/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double currentAgeValue = 21;
  double currentYearValue = 1;
  String unitTypeValue = '';
  var unitTypeValueItems = [
    '',
    'Residential',
    'Non-Residential',
    'Second home',
  ];
  var currentFinanceValue = TextEditingController();
  var currentUnitValue = TextEditingController();

  int currentCategoryIndex = 0;
  List<CategoryModel> category = [
    CategoryModel(text: 'resedential1.png', isSelected: false,tenor:'15',ftv: '80', financeAmount: '15'),
    CategoryModel(text: 'nonResedential1.png', isSelected: false,tenor:'10',ftv: '70', financeAmount: '25'),
    CategoryModel(text: 'secondhome.png', isSelected: false,tenor:'15',ftv: '70', financeAmount: '15'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeStates>(
      builder: (context,state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed:(){},
                          child: Text('Installment calculator',
                          style: CustomTextStyle.captionsBold(context).copyWith(
                            color: ColorStyle.caption,
                          ),
                          ),
                      ),
                      Text('|',
                        style: CustomTextStyle.captionsBold(context).copyWith(
                          color: ColorStyle.caption,
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          cubit.logOut().then((value) => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                                (route) {
                              return false;
                            },
                          ));
                        },
                        color: ColorStyle.caption,
                        icon: Icon(Icons.logout,size: 20.sp),
                      ),
                    ],
                  ),
                  const Image(image:AssetImage('assets/images/key.jpg'),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// category btns
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: category.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  category.forEach((element) => element.isSelected = false);
                                  category[index].isSelected = true;
                                  currentCategoryIndex = index;
                                });
                              },
                              child: categoryItem(img: category[index].text, isSelected: category[index].isSelected),
                            );
                          },
                        ),
                        SizedBox(
                          height: 5.w,
                        ),
                        ///overview
                        Center(
                          child: Text('Overview',
                            style: CustomTextStyle.titleRegular(context).copyWith(
                              color: ColorStyle.mainColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.w,
                        ),
                        Text('● Purchase new unit\n● Extend installment tenor \n● Refinance ,buy &lease back',
                          style: CustomTextStyle.body1Regular(context).copyWith(
                            color: ColorStyle.baseBlack,
                          ),
                        ),
                        /// features
                        SizedBox(
                          height: 20.w,
                        ),
                        Center(
                          child: Text('Features:',
                            style: CustomTextStyle.headLineBold(context).copyWith(
                              color: ColorStyle.mainColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.w,
                        ),
                        Text('● Tenor up to : ${category[currentCategoryIndex].tenor} years\n● FTV up to : ${category[currentCategoryIndex].ftv}% \n● Financed amount up to: ${category[currentCategoryIndex].financeAmount}Mn',
                          style: CustomTextStyle.body1Regular(context).copyWith(
                            color: ColorStyle.baseBlack,
                          ),
                        ),
                        ///Eligibility criteria
                        SizedBox(
                          height: 20.w,
                        ),
                        Center(
                          child: Text('Eligibility criteria:',
                            style: CustomTextStyle.headLineBold(context).copyWith(
                              color: ColorStyle.mainColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.w,
                        ),
                        Text('● Egyptians\n● Expats \n● Non-Egyptian (resident)',
                          style: CustomTextStyle.body1Regular(context).copyWith(
                            color: ColorStyle.baseBlack,
                          ),
                        ),
                        SizedBox(
                          height: 40.w,
                        ),
                      ],
                    ),
                  ),


                  ///Calculate your Installments
                  Container(
                    width: double.infinity,
                    color: ColorStyle.mainColor,
                    padding: EdgeInsets.symmetric(vertical: 50.w,horizontal: 30.w),
                    child: Container(
                      width: double.infinity,
                      color: ColorStyle.baseWhite,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.w,horizontal: 80.0.w),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Calculate your Installments',
                                style: CustomTextStyle.titleRegular(context).copyWith(
                                  color: ColorStyle.mainColor,
                                ),
                              ),
                              SizedBox(
                                height: 10.w,
                              ),
                              Text('Monthly Installment as per finance amount value',
                                style: CustomTextStyle.body1Regular(context).copyWith(
                                  color: ColorStyle.caption,
                                ),
                              ),
                              SizedBox(
                                height: 30.w,
                              ),
                              ///Unit type (type of product)
                              RichText(
                                text: TextSpan(
                                    text: 'Unit type (type of product)',
                                    style: CustomTextStyle.body1Regular(context).copyWith(
                                      color: ColorStyle.caption,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: ' *',
                                        style: CustomTextStyle.body1Regular(context).copyWith(
                                          color: ColorStyle.darkTextError,
                                        ),)
                                    ]),
                              ),
                              DropDown(
                                items:  unitTypeValueItems,
                                value: unitTypeValue,
                                onChanged:(value){
                                  setState(() {
                                    unitTypeValue = value!;
                                  });
                                }
                              ),
                              SizedBox(
                                height: 30.w,
                              ),
                              ///age
                              RichText(
                                text: TextSpan(
                                    text: 'age',
                                    style: CustomTextStyle.body1Regular(context).copyWith(
                                      color: ColorStyle.caption,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' * ',
                                        style: CustomTextStyle.body1Regular(context).copyWith(
                                          color: ColorStyle.darkTextError,
                                        ),),
                                      TextSpan(
                                        text: '${currentAgeValue.round()}',
                                        style: CustomTextStyle.body1Regular(context).copyWith(
                                          color: ColorStyle.caption,
                                        ),)
                                    ]),
                              ),
                              Slider(
                                value: currentAgeValue,
                                max: 65,
                                min: 21,
                                onChanged: (double value) {
                                  setState(() {
                                    currentAgeValue = value;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 30.w,
                              ),
                              ///Tenor in years
                              RichText(
                                text: TextSpan(
                                    text: 'Tenor in years',
                                    style: CustomTextStyle.body1Regular(context).copyWith(
                                      color: ColorStyle.caption,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' * ',
                                        style: CustomTextStyle.body1Regular(context).copyWith(
                                          color: ColorStyle.darkTextError,
                                        ),),
                                      TextSpan(
                                        text: '${currentYearValue.round()}',
                                        style: CustomTextStyle.body1Regular(context).copyWith(
                                          color: ColorStyle.caption,
                                        ),)
                                    ]),
                              ),
                              Slider(
                                value: currentYearValue,
                                max: 15,
                                min: 1,
                                onChanged: (double value) {
                                  setState(() {
                                    currentYearValue = value;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 30.w,
                              ),
                              ///Finance value
                              RichText(
                                text: TextSpan(
                                    text: 'Finance value',
                                    style: CustomTextStyle.body1Regular(context).copyWith(
                                      color: ColorStyle.caption,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' * ',
                                        style: CustomTextStyle.body1Regular(context).copyWith(
                                          color: ColorStyle.darkTextError,
                                        ),),
                                    ]),
                              ),
                              MainTextField(
                                controller: currentFinanceValue,
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(
                                height: 30.w,
                              ),
                              ///Unit value
                              RichText(
                                text: TextSpan(
                                    text: 'Unit value',
                                    style: CustomTextStyle.body1Regular(context).copyWith(
                                      color: ColorStyle.caption,
                                    ),),
                              ),
                              MainTextField(
                                controller: currentUnitValue,
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(
                                height: 30.w,
                              ),
                              ///calculate button
                              MainBtn(
                                text: 'Calculate',
                                onPressed: (){
                                  cubit.calculateInstallments(
                                    n: currentYearValue.round()*12,
                                    p: currentFinanceValue.text.replaceAll(RegExp('[^0-9]'), ''),
                                    age: currentAgeValue.round(),
                                    unitType: unitTypeValue,
                                  );
                                },
                                color:ColorStyle.btnColor,
                              ),
                              ///result
                              SizedBox(height: 10.w,),
                              if(cubit.result.isNotEmpty)
                              Text(
                                'Total Monthly Installment: ${cubit.result}',
                                textAlign: TextAlign.center,
                                style: CustomTextStyle.body1Regular(context).copyWith(
                                  color: ColorStyle.caption,
                                ),
                              ),
                              SizedBox(
                                height: 20.w,
                              ),
                              ///terms and conditions
                              if(cubit.alertText.isNotEmpty)
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: '*',
                                    style: CustomTextStyle.body1Regular(context).copyWith(
                                      color: ColorStyle.darkTextError,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: cubit.alertText,
                                        style: CustomTextStyle.body1Regular(context).copyWith(
                                          color: ColorStyle.darkTextError,
                                        ),),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}


Widget categoryItem({
  required String img,
  required bool isSelected,
})=>Container(
  width: double.infinity,
  height: 100.w,
  decoration: BoxDecoration(
    color: isSelected? ColorStyle.baseWhite: ColorStyle.lightGray,
  ),
  child:Image(image: AssetImage('assets/images/$img'),),
);

class CategoryModel {
  bool isSelected;
  String text;
  String tenor;
  String ftv;
  String financeAmount;

  CategoryModel({required this.isSelected, required this.text , required this.tenor, required this.ftv, required this.financeAmount});
}