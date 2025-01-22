import 'package:sqlite_1/db.dart';
import 'package:sqlite_1/animal.dart';
import 'package:flutter/material.dart';

class Editar extends StatefulWidget {
  @override
  _EditarState createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final especieController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Obtener los argumentos pasados a esta pantalla
    final args = ModalRoute.of(context)?.settings.arguments;

    // Validar si los argumentos son correctos
    if (args == null || args is! Animal) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(
          child: Text("No se pasaron argumentos válidos"),
        ),
      );
    }

    // Inicializar el objeto animal
    Animal animal = args;
    nombreController.text = animal.nombre ?? "";
    especieController.text = animal.especie ?? "";

    return Scaffold(
      appBar: AppBar(title: Text("Guardar")),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nombreController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "El nombre es obligatorio";
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Nombre"),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: especieController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "La especie es obligatoria";
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Especie"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Validar el formulario
                  if (_formKey.currentState?.validate() ?? false) {
                    // Verificar si es una actualización o una inserción
                    if ((animal.id ?? 0) > 0) {
                      // Actualizar el animal existente
                      animal.nombre = nombreController.text;
                      animal.especie = especieController.text;
                      DB.update(animal);
                    } else {
                      // Insertar un nuevo animal
                      DB.insert(Animal(
                        nombre: nombreController.text,
                        especie: especieController.text,
                      ));
                    }
                    // Volver a la pantalla principal
                    Navigator.pushNamed(context, "/");
                  }
                },
                child: Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Liberar los controladores cuando el widget se destruya
    nombreController.dispose();
    especieController.dispose();
    super.dispose();
  }
}
