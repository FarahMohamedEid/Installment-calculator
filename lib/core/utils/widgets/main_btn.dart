import 'package:flutter/material.dart';
import 'package:installment_calculator/core/utils/resources/color_styles.dart';
import 'package:installment_calculator/core/utils/resources/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainBtn extends StatelessWidget {
  MainBtn({
    required this.onPressed,
    required this.text,
    required this.color,
    this.width,
    this.height,
    Key? key}) : super(key: key);

  Function onPressed;
  String text;
  Color color;
  double? width;
  double? height;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
       onPressed();
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0.w),
        primary: ColorStyle.baseBlack,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
      child: SizedBox(
        width: width ?? 100.w,
        height: height ?? 45.w,
        child: Center(
          child: Text(
            text,
            style: CustomTextStyle.body1Regular(context).copyWith(
              color: ColorStyle.baseWhite,
            ),
          ),
        ),
      ),
    );
  }
}
