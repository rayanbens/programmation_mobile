import 'package:flutter/material.dart';

class CenterWidget extends StatelessWidget {
  const CenterWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: child),
      ],
    );
  }
}
