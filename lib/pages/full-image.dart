import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FullImage extends StatelessWidget {
  const FullImage({super.key, required this.imageURL, required this.sector});
  final String imageURL;
  final String sector;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 32, 32, 32),
      appBar: AppBar(
        title: Text(
          sector,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 16, 16, 16),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.network(imageURL),
      ),
    );
  }
}
