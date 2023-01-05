// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class WidgetToImage extends StatefulWidget {
  const WidgetToImage({
    super.key,
    required this.gKey,
    required this.child,
  });
  final GlobalKey gKey;
  final Widget child;
  @override
  State<WidgetToImage> createState() => _WidgetToImageState();
}

class _WidgetToImageState extends State<WidgetToImage> {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: widget.gKey,
      child: widget.child,
      // child: Container(
      //   height: 200,
      //   width: 200,
      //   color: Colors.amber,
      //   child: Stack(
      //     children: [
      //       Center(
      //         child: Container(
      //           height: 100,
      //           width: 100,
      //           decoration: BoxDecoration(
      //             color: Colors.red,
      //             borderRadius: BorderRadius.circular(100),
      //           ),
      //         ),
      //       ),
      //       Center(
      //         child: Text(
      //           'Test',
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
