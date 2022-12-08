import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:installment_calculator/core/utils/resources/color_styles.dart';
import 'package:installment_calculator/core/utils/widgets/main_text_field.dart';

class Captcha extends StatefulWidget {
  Captcha({ required this.cap});

  CapModel cap;
  @override
  State<Captcha> createState() => _CaptchaState();


}

class _CaptchaState extends State<Captcha> {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return capItem(cap: widget.cap);
            },
          ),
        ],
      );
  }
}


class CapModel {
  String imgPath;
  String text;

  CapModel({required this.imgPath, required this.text});
}

Widget capItem({
  required CapModel cap,
}) => Container(
        width: double.infinity,
        height: 50.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(
            color: ColorStyle.lightGray,
          ),
        ),
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/images/${cap.imgPath}',
          ),
        ),
      );

