// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:wakala/models/wakalaDetail.dart';
import 'package:wakala/pages/full-image.dart';

import '../global.dart';
import '../models/comentarios.dart';
import '../services/commentsService.dart';
import '../services/wakalasService.dart';

class WakalaScreen extends StatefulWidget {
  const WakalaScreen({super.key, required this.id});

  final int id;

  @override
  State<WakalaScreen> createState() => _WakalaScreenState(id: id);
}

class _WakalaScreenState extends State<WakalaScreen> {
  final id;
  _WakalaScreenState({required this.id});
  TextEditingController commentController = TextEditingController();

  List<String> images = <String>[];

  WakalaDetail wakala = WakalaDetail(
      sector: "", descripcion: "", autor: "", fechaPublicacion: "");

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    this.getWakala();
  }

  Future<void> getWakala() async {
    final response = await WakalasService().getWakala(id);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final aux = WakalaDetail.fromJson(json);
      if (aux.urlFoto1!.isNotEmpty) images.add(aux.urlFoto1!);
      if (aux.urlFoto2!.isNotEmpty) images.add(aux.urlFoto2!);
      setState(() {
        wakala = aux;
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  void putSigueAhi() async {
    final response = await WakalasService().putSigueAhi(id);
    if (response.statusCode == 200) {
      int aux = await jsonDecode(response.body);
      setState(() {
        wakala.sigueAhi = aux;
      });
    }
  }

  void putYaNoEsta() async {
    final response = await WakalasService().putYaNoEsta(id);
    if (response.statusCode == 200) {
      int aux = await jsonDecode(response.body);
      setState(() {
        wakala.yaNoEsta = aux;
      });
    }
  }

  void postComment(String comentario) async {
    final comment = new Map<String, dynamic>();
    comment['id_wuakala'] = wakala.id;
    comment['descripcion'] = comentario;
    comment['id_autor'] = Global.login;
    final response = await CommentsService().postComment(comment);
    if (response.statusCode == 200) {
      await getWakala();
      commentController.clear();
    } else {
      final snackbar = SnackBar(
        content: Text('Error al cargar tu comentario: ${response.statusCode}'),
        backgroundColor: Colors.red,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      print(comment);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 32, 32, 32),
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 48, 48, 48),
          title: Text(wakala.sector!),
          elevation: 0,
        ),
        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      height: max(500, constraints.maxHeight)),
                  child: Column(
                    children: [
                      // wakala post
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 48, 48, 48),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(1),
                              spreadRadius: 5,
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(25),
                        child: Column(
                          children: [
                            // Image carrousel
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 200,
                                enableInfiniteScroll: false,
                                viewportFraction: 1,
                                autoPlay: true,
                              ),
                              items: images.map((i) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(0),
                                    shadowColor: Colors.transparent,
                                    backgroundColor: Colors.transparent,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FullImage(
                                            imageURL:
                                                'https://985cd18612e9.sa.ngrok.io/images/${i}',
                                            sector: wakala.sector),
                                      ),
                                    );
                                  },
                                  child: Image.network(
                                      'https://985cd18612e9.sa.ngrok.io/images/' +
                                          i),
                                );
                              }).toList(),
                            ),

                            SizedBox(height: 20),

                            // Description
                            Container(
                              width: double.infinity,
                              child: Text(
                                wakala.descripcion!,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),

                            SizedBox(height: 10),

                            // Autor
                            Container(
                              width: double.infinity,
                              child: Text(
                                'Subido por @' +
                                    wakala.autor! +
                                    ' el ' +
                                    wakala.fechaPublicacion!,
                                style: TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                            ),

                            SizedBox(height: 20),

                            // rating buttons
                            Row(
                              children: [
                                //sigue ahí button
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.green,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        putSigueAhi();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        shadowColor: Colors.transparent,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.thumb_up_alt,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Sigue ahí (${wakala.sigueAhi})',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10),

                                // ya no está button
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.red,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        putYaNoEsta();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        shadowColor: Colors.transparent,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.thumb_down_alt,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Ya no está (${wakala.yaNoEsta})',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                      // comentarios body
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: wakala.comentarios!.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 10,
                              ),
                              child: Column(
                                children: [
                                  // Usuario y fecha comentario
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '@${wakala.comentarios![index].autor!}',
                                          style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        '${wakala.comentarios![index].fechaComentario!}',
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 5),

                                  // Comentario
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      wakala.comentarios![index].descripcion!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),

                      // input new comment
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 48, 48, 48),
                            border: Border.all(
                              color: const Color.fromARGB(255, 64, 64, 64),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: commentController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Añade un comentario',
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 128, 128, 128),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.comment,
                                      color: Color.fromARGB(255, 128, 128, 128),
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: EdgeInsets.all(0),
                                ),
                                onPressed: () {
                                  if (commentController.text.isEmpty) {
                                    final snackbar = SnackBar(
                                      content: const Text(
                                          'Debe escribir un comentario'),
                                      backgroundColor: Colors.red,
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                  } else {
                                    postComment(commentController.text);
                                  }
                                },
                                child: Icon(Icons.send, color: Colors.white54),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
