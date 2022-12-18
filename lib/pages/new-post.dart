// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:image_picker/image_picker.dart';

import '../global.dart';
import 'package:flutter/material.dart';

class NewWakala extends StatefulWidget {
  const NewWakala({super.key});

  @override
  State<NewWakala> createState() => _NewWakalaState();
}

class _NewWakalaState extends State<NewWakala> {
  TextEditingController sectorController = TextEditingController();
  TextEditingController descController = TextEditingController();

  File? image1;
  File? image2;

  Future takePicture1() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      this.image1 = imageTemporary;
    } on PlatformException catch (e) {
      print('Error al cargar imagen');
    }
  }

  Future deletePicture1() async {
    if (this.image1 == null) return;
    image1 = null;
  }

  Future takePicture2() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      this.image2 = imageTemporary;
    } on PlatformException catch (e) {
      print('Error al cargar imagen');
    }
  }

  Future deletePicture2() async {
    if (this.image2 == null) return;
    image1 = null;
  }

  @override
  Widget build(BuildContext context) {
    const logo = AssetImage('assets/logo.png');

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image(image: logo, height: 50),
            SizedBox(width: 20),
            Text('Nuevo Wakala'),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 16, 16, 16),
      ),
      backgroundColor: Color.fromARGB(255, 32, 32, 32),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Sector input
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 48, 48, 48),
                      border: Border.all(
                        color: const Color.fromARGB(255, 64, 64, 64),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: sectorController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Sector',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 128, 128, 128),
                        ),
                        prefixIcon: Icon(
                          Icons.location_pin,
                          color: Color.fromARGB(255, 128, 128, 128),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Description input
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 48, 48, 48),
                      border: Border.all(
                        color: const Color.fromARGB(255, 64, 64, 64),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: descController,
                      maxLines: null,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Descripción',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 128, 128, 128),
                        ),
                        prefixIcon: Icon(
                          Icons.description,
                          color: Color.fromARGB(255, 128, 128, 128),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Foto selector
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            // take photo button
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 48, 48, 48),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 64, 64, 64),
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  takePicture1();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 48, 48, 48),
                                  shadowColor: Colors.transparent,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text('Agregar foto 1')
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 10),

                            // Image preview
                            Container(
                              width: double.infinity,
                              height: 160,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 48, 48, 48),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 64, 64, 64),
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: image1 != null
                                  ? Image.file(
                                      image1!,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.camera_alt,
                                      color: Colors.white54,
                                      size: 50,
                                    ),
                            ),

                            SizedBox(height: 10),

                            // Delete Button
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  deletePicture1();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shadowColor: Colors.transparent,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text('Borrar foto 1'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: [
                            // take photo button
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 48, 48, 48),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 64, 64, 64),
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  takePicture2();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 48, 48, 48),
                                  shadowColor: Colors.transparent,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text('Agregar foto 2')
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 10),

                            // Image preview
                            Container(
                              width: double.infinity,
                              height: 160,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 48, 48, 48),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 64, 64, 64),
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: image2 != null
                                  ? Image.file(
                                      image2!,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.camera_alt,
                                      color: Colors.white54,
                                      size: 50,
                                    ),
                            ),

                            SizedBox(height: 10),

                            // Delete Button
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  deletePicture2();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shadowColor: Colors.transparent,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text('Borrar foto 2'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Publicar wakala button
                  Container(
                    decoration: BoxDecoration(
                        border: const GradientBoxBorder(
                          gradient: LinearGradient(
                            colors: [
                              Colors.pink,
                              Colors.blue,
                              Colors.green,
                              Colors.yellow,
                              Colors.orange,
                            ],
                          ),
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 16, 16, 16)),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            'Publicar wakala',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Cancel button
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 64, 64, 64),
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 48, 48, 48)),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 48, 48, 48),
                        shadowColor: Colors.transparent,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(18),
                        child: Center(
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
