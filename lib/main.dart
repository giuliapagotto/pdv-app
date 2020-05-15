import 'package:flutter/material.dart';
import 'package:fluttertreinaweb/Telas/login.dart';


const RoxoBonito = const Color(0xFF7953D2);

class VendasApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Página Principal',
      theme: ThemeData(
        primaryColor: RoxoBonito,
      ),
      home: LoginScreen(),
    );
  }
}


void main(){
  runApp(new VendasApp());
}  // OU void main() => runApp(new VendasApp());
