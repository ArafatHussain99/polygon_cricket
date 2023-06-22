import 'package:flutter/material.dart';

class RunButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const RunButton(
      {Key? key, this.color, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(50, 50),
        backgroundColor: color,
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
