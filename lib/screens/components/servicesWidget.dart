import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'customtext.dart';

class RoundedImage extends StatelessWidget {
  final String imageAsset;
  final String imageURL;
  final Function onTap;

  const RoundedImage({
    this.imageAsset,
    this.imageURL,
    this.onTap
  }):assert(!(imageAsset!=null && imageURL!=null));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap??(){
          print("Tapped Rounded Image");
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1,5),
                spreadRadius: -4,
                blurRadius: 6,
              ),
            ],
            color: Colors.white,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child:ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: imageAsset!=null?Image.asset(
                imageAsset,
                fit: BoxFit.contain,
            ):CachedNetworkImage(imageUrl: imageURL)
            )
      ));
  }
}