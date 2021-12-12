import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchingTextFieldWidget extends StatelessWidget {
  const SearchingTextFieldWidget({
    Key? key,
    required this.onSubmitted,
  }) : super(key: key);

  final Function(String value) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: TextField(
        autofocus: true,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) => onSubmitted(value),
        decoration: textFieldDecoration,
      ),
    );
  }

  InputDecoration get textFieldDecoration => InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: "Enter a keyword",
        hintStyle: TextStyle(color: Colors.black54),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(7.0.r)),
        ),
      );
}
