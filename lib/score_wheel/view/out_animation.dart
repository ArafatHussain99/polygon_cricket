import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:polygon_cricket/global.dart';

class OutAnimation extends StatefulWidget {
  const OutAnimation({super.key});

  @override
  State<OutAnimation> createState() => _OutAnimationState();
}

class _OutAnimationState extends State<OutAnimation> {
  List<String> images = [
    'assets/images/out.jpg',
    'assets/images/out1.jpg',
    'assets/images/out2.jpg',
    'assets/images/out1.jpg',
    'assets/images/out2.jpg',
    'assets/images/out1.jpg',
    'assets/images/out2.jpg',
    'assets/images/out1.jpg',
    'assets/images/out2.jpg',
    'assets/images/out1.jpg',
    'assets/images/out2.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 5000), () {
      Global.animation = false;
      Global.currentBatsman = -1;
      Global.check(context);
    });
    null;
    return SizedBox(
      height: 570,
      child: CarouselSlider(
        options: CarouselOptions(
            height: double.infinity,
            autoPlay: true,
            autoPlayInterval: const Duration(milliseconds: 1000),
            enableInfiniteScroll: true,
            scrollPhysics: null,
            autoPlayAnimationDuration: const Duration(milliseconds: 10),
            viewportFraction: 1),
        items: images.map((item) {
          return Center(
              child: Image.asset(
            item,
          ));
        }).toList(),
      ),
    );
  }
}
