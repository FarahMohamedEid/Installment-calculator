import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:installment_calculator/core/utils/resources/color_styles.dart';


class DropDown extends StatelessWidget {
  DropDown({
    required this.items,
    required this.value,
    required this.onChanged,
    Key? key}) : super(key: key);

  List<String> items;
  String value;
  Function onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomDropdownButton2(
      hint: '',
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 18.sp,
      buttonPadding: EdgeInsets.symmetric(horizontal: 10.w),
      buttonWidth: double.infinity,
      buttonHeight: 50.w,
      buttonDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          color: ColorStyle.lightGray,
        ),
      ),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          color: ColorStyle.lightGray,
        ),
      ),
      dropdownItems: items,
      value: value,
      onChanged: (value) {
        onChanged(value);
      },
    );
  }

}
