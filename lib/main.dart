import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_1/listado.dart';
import 'package:sqlite_1/editar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'prueba 1',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(), // Usamos una clase separada para la página principal
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/":(context)=>Listado(),
        "/editar":(context)=>Editar()
      },
    );
  }
}