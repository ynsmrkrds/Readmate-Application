import 'package:flutter/material.dart';

class CoverImageWidget extends StatelessWidget {
  const CoverImageWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String? url;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      image: NetworkImage(url ?? ""),
      placeholder: const AssetImage("assets/loading.gif"),
      imageErrorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.image_not_supported_outlined,
          size: 50,
        );
      },
      fit: BoxFit.fitWidth,
    );
  }
}
