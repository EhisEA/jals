import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jals/widgets/image_loader.dart';

class ShowNetworkImage extends StatelessWidget {
  final String imageUrl;

  const ShowNetworkImage({Key key, @required this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      errorWidget: (context, _, __) {
        return Container(
          alignment: Alignment.center,
          color: Colors.grey.withOpacity(0.3),
          child: Icon(Icons.error_outline, color: Colors.red),
        );
      },
      placeholder: (context, _) {
        return ImageShimmerLoadingState();
      },
      imageUrl: imageUrl,
    );
  }
}
