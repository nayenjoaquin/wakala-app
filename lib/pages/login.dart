import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:wakala/pages/home.dart';
import 'package:wakala/services/loginService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final pref;

  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Future<void> validarDatos(String email, String password) async {
    final response = await LoginService().validar(email, password);

    if (response.statusCode == 200) {
      //almacenar de alguna manera el login

      await pref.setString('usuario', email);

      Global.login = email;
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else {
      final snackbar = SnackBar(
        content: const Text('Error al iniciar sesión, intente nuevamente'),
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

  String? loginGuardado = "";

  @override
  void initState() {
    super.initState();
    cargaPreferencia();
  }

  void cargaPreferencia() async {
    pref = await SharedPreferences.getInstance();
    loginGuardado = pref.getString("usuario");
    mailController.text = loginGuardado == null ? "" : loginGuardado!;
  }

  @override
  Widget build(BuildContext context) {
    const logo = AssetImage('assets/logo.png');
    const backgroundColor = Color.fromARGB(255, 32, 32, 32);
    const textColor = Color.fromARGB(255, 255, 255, 255);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // logo
                  const Image(
                    image: logo,
                    width: 200,
                  ),

                  const SizedBox(height: 20),

                  // Hello again!
                  Text(
                    "Hola de nuevo!",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Inicia sesión para descubrir wakalas cerca",
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 50),

                  // email textfield
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 48, 48, 48),
                      border: Border.all(
                        color: const Color.fromARGB(255, 64, 64, 64),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: mailController,
                      style: const TextStyle(color: textColor),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Correo',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 128, 128, 128),
                        ),
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Color.fromARGB(255, 128, 128, 128),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // pass textfield
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 48, 48, 48),
                      border: Border.all(
                        color: const Color.fromARGB(255, 64, 64, 64),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: passController,
                      style: const TextStyle(color: textColor),
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Contraseña',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 128, 128, 128),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color.fromARGB(255, 128, 128, 128),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // login button
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
                      onPressed: () {
                        if (mailController.text.isEmpty ||
                            passController.text.isEmpty) {
                          final snackbar = SnackBar(
                            content: const Text(
                                'Debe ingresar un correo y contraseña válido'),
                            backgroundColor: Colors.red,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        } else {
                          validarDatos(
                              mailController.text, passController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            'Iniciar sesión',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  //register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '¿No estás registrado?',
                        style: TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                      Text(
                        ' Crea una cuenta',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 50),

                  Text(
                    'Made by Joaquín Nayen',
                    style: TextStyle(
                      color: Colors.white30,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
