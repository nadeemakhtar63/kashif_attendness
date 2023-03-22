//This is a Custom Button Widget.
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

// In the Constructor onTap and Symbol fields are added.
  const CustomButton({Key? key, required this.onTap, required this.text}) : super(key: key);

// It Requires 2 fields Symbol(to be displayed)
// and onTap Function
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // The onTap Field is used here.
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width*0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          //shape: BoxShape.circle,
          color: Color(0xffFF7D00),
        ),
        child: Center(
          child: Text(

            // The Symbol is used here
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
