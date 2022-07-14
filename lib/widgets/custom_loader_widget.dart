import 'package:flutter/material.dart';

class CustomLoaderWidget extends StatelessWidget {
  const CustomLoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
