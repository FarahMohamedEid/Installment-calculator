import 'package:flutter/material.dart';
import 'package:installment_calculator/core/network/local/cache_helper.dart';
import 'package:installment_calculator/core/utils/resources/color_styles.dart';
import 'package:installment_calculator/core/utils/resources/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RadioBtn extends StatefulWidget {
  RadioBtn({
    required this.data,
    required this.radioName,
    Key? key}) : super(key: key);

  List<RadioModel> data;
  String radioName;


  @override
  State<RadioBtn> createState() => _RadioBtnState();

}

class _RadioBtnState extends State<RadioBtn> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.data.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            setState(() {
              widget.data.forEach((element) => element.isSelected = false);
              widget.data[index].isSelected = true;
              CacheHelper.saveData(key: widget.radioName,value: widget.data[index].text);
            });
          },
          child: RadioItem(widget.data[index]),
        );
      },
    );

  }
}


class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          _item.isSelected
            ? Icons.radio_button_checked
            : Icons.radio_button_off,
          color: _item.isSelected
              ? ColorStyle.mainColor
              : ColorStyle.caption,
          size: 20.sp,
        ),
        Container(
          margin: EdgeInsets.only(left:6.w),
          child: Text(_item.text,
            style:  CustomTextStyle.body2Regular(context).copyWith(
              color: ColorStyle.baseBlack,
            ),
          ),
        )
      ],
    );
  }
}

class RadioModel {
  bool isSelected;
  final String text;

  RadioModel({required this.isSelected, required this.text});
}