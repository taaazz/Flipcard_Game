import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;

  const SquareTile({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Aksi ketika gambar diklik
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          imagePath,
          width: 40, // Sesuaikan lebar gambar
          height: 40, // Sesuaikan tinggi gambar
        ),
      ),
    );
  }
}
