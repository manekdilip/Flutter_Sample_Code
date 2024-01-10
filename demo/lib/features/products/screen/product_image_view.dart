import 'package:demo/core/constant/color.dart';
import 'package:flutter/material.dart';

class ProductImageView extends StatelessWidget {
  final String path;
  const ProductImageView(this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackTransColor,
        appBar: AppBar(
          backgroundColor: blackTransColor,
        ),
        body: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.network(path),
        ));
  }
}
