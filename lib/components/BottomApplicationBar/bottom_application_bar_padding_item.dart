import 'package:flutter/cupertino.dart';

class BottomApplicationBarPaddingItem extends StatelessWidget{
  final double width;

  const BottomApplicationBarPaddingItem({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}