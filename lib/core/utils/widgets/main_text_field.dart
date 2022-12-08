import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:installment_calculator/core/utils/resources/color_styles.dart';
import 'package:installment_calculator/core/utils/resources/text_styles.dart';


class MainTextField extends StatelessWidget {
  MainTextField({required this.controller ,
    required this.keyboardType,
    this.validator,
    Key? key}) : super(key: key);

  TextEditingController controller;
  TextInputType keyboardType;
  Function? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          color: ColorStyle.lightGray,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: TextFormField(
          controller: controller,
          maxLines: 1,
          style: CustomTextStyle.body2Regular(context).copyWith(
            color: ColorStyle.baseBlack,
            overflow: TextOverflow.visible,

          ),
          validator: (value) {
            if (validator != null) {
              return validator!(value);
            }
            return null;
          },
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            errorStyle: CustomTextStyle.captionsBold(context).copyWith(
              color: ColorStyle.darkTextError,
            ),
          ),
        ),
      ),
    );
  }
}
