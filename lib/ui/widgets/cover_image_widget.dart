import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoverImageWidget extends StatelessWidget {
  final String? url;
  final double height;

  const CoverImageWidget({
    Key? key,
    required this.url,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      image: NetworkImage(url ?? ""),
      height: height,
      placeholder: const AssetImage("assets/loading.gif"),
      imageErrorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.image_not_supported_outlined,
          size: 50.w,
        );
      },
      fit: BoxFit.fitWidth,
    );
  }
}
