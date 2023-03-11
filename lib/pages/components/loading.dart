import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: JumpingDotsProgressIndicator(
        color: (Theme.of(context).iconTheme.color)!,
        fontSize: 80,
        dotSpacing: 3,
      ),
    );
  }
}
