import 'package:flutter/material.dart';
import 'package:smart_home_dev/common/constants.dart';

class ImageFromNetwork extends StatelessWidget {
  final String path;
  final String defaultAsset;
  final BoxFit fit;
  final double? height, width;

  const ImageFromNetwork(this.path,
      {this.width,
      this.height,
      this.fit = BoxFit.fill,
      this.defaultAsset = 'assets/images/theme/ic_default.png',
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (path.isNotEmpty) {
      return FadeInImage.assetNetwork(
          image: Constants.baseUrl + path,
          imageErrorBuilder: (context, obj, stack) {
            return Image.asset(defaultAsset,
                fit: fit, height: height, width: width);
          },
          placeholder: defaultAsset,
          fit: fit,
          height: height,
          width: width);
    }
    return Image.asset(defaultAsset, fit: fit, height: height, width: width);
  }
}
