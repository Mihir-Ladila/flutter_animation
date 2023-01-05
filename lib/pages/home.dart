// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:permission_handler/permission_handler.dart';
import 'package:widget_to_photo/pages/second_page.dart';
import 'package:widget_to_photo/pages/widget_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  GlobalKey gKey = GlobalKey();
  late Uint8List? pngBytes;
  bool showImage = false;
  double opacity = 0;
  late AnimationController controller;
  late Animation<double> anim;
  @override
  void initState() {
    initializeAnim();
    Timer.periodic(Duration(seconds: 2), (_) {
      changeImplicitAnim();
    });

    super.initState();
  }

  void initializeAnim() async {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    anim = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  void saveWidgetImage() async {
    if (await Permission.storage.request().isGranted) {
      RenderRepaintBoundary boundary =
          gKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();

      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      pngBytes = byteData!.buffer.asUint8List();

      File file = await File(
        '/storage/emulated/0/download/image${Random().nextInt(100)}.png',
      ).create();
      await file.writeAsBytes(
        pngBytes!.toList(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Photo Saved.'),
        ),
      );
    }
  }

  void changeImplicitAnim() {
    opacity == 0 ? opacity = 1 : opacity = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: saveWidgetImage,
        child: Icon(Icons.save),
      ),
      body: WidgetToImage(
        gKey: gKey,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedOpacity(
                curve: Curves.linear,
                opacity: opacity,
                duration: Duration(seconds: 2),
                child: Text('Animated opacity using implicit animation'),
              ),
              Divider(thickness: 2),
              SizedBox(
                height: 120,
                child: Column(
                  children: [
                    SizedBox(
                      height: anim.value * 70,
                    ),
                    Opacity(
                      opacity: anim.value,
                      child: Text('Animated opacity using staggered animation'),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 2),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(seconds: 10),
                builder: (context, opa, child) {
                  return Text(
                    'tween Animation Builder',
                    style: TextStyle(fontSize: opa * 25),
                  );
                },
              ),
              Divider(thickness: 2),
              Lottie.asset(
                'assets/lottiefiles/lego_loader.json',
                height: 200,
                width: 200,
              ),
              Divider(thickness: 2),
              Hero(
                tag: 'tag',
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondPage(),
                      ),
                    );
                  },
                  child: Text('data'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
