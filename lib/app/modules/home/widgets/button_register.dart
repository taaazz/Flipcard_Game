import 'package:flutter/material.dart';

class ButtonRegister extends StatelessWidget {
  final Function()? onTap;

  const ButtonRegister({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.7,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            minimumSize: Size(width * 0.7, 50),
          ),
          child: const Center(
            child: Text(
              "Sign Up",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
