import 'package:flutter/material.dart';

class MyFilledButton extends StatelessWidget {
  GestureTapCallback onTap;
  String label;

   MyFilledButton(this.onTap,this.label);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: double.infinity,
        color: Colors.pink,
        child: Center(child: Text(label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
      ),
    );
  }
}
