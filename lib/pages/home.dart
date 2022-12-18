import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:wakala/pages/new-post.dart';
import 'package:wakala/services/wakalasService.dart';

import '../models/wakala.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  getWakalas() async {
    var response = await WakalasService().getWakalas();
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final snackbar = SnackBar(
        content: const Text('Error al obtener los wakalas'),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Ok',
          textColor: Colors.white,
          onPressed: (() {}),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color.fromARGB(255, 32, 32, 32);
    const textColor = Color.fromARGB(255, 255, 255, 255);
    const logo = AssetImage('assets/addWakala.png');

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewWakala()),
          );
        },
        backgroundColor: Colors.transparent,
        child: const Image(
          image: logo,
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: FutureBuilder(
          future: getWakalas(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    // WAKALAS CARDS
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: Color.fromARGB(255, 16, 16, 16),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side:
                            BorderSide(color: Color.fromARGB(255, 48, 48, 48)),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            // Wakalas Info
                            Expanded(
                              child: Column(
                                children: [
                                  // Ubicación
                                  Text(
                                    snapshot.data[index]['sector'],
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  //Autor y fecha
                                  Text(
                                    "por @" +
                                        snapshot.data[index]['autor'] +
                                        " " +
                                        snapshot.data[index]['fecha'],
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: 20),

                            // Wakalas icon
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                              ),
                              child: Icon(
                                Icons.chevron_right,
                                size: 32,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(
                  child: CircularProgressIndicator(
                color: textColor,
              ));
            }
          },
        ),
      ),
    );
  }
}
