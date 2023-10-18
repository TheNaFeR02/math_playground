import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:math_playground/ui/controller/user_controller.dart';
import 'package:math_playground/ui/menu.dart';
import 'package:math_playground/ui/pages/content/operation_list.dart';

// Define a custom Form widget.
class IntroductoryForm extends StatefulWidget {
  const IntroductoryForm({super.key});

  @override
  IntroductoryFormState createState() {
    return IntroductoryFormState();
  }
}

class IntroductoryFormState extends State<IntroductoryForm> {
  final _formKey = GlobalKey<FormState>();
  final controllerSchool = TextEditingController(text: '');
  final controllerGrade = TextEditingController(text: '');
  final controllerDatebirth = TextEditingController(text: '');
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Bienvenido!",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLength: 50,
                      keyboardType: TextInputType.emailAddress,
                      controller: controllerSchool,
                      decoration:
                          const InputDecoration(labelText: "Nombre de Colegio"),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Ingresa tu Colegio";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controllerGrade,
                      decoration: const InputDecoration(labelText: "Grado"),
                      keyboardType: TextInputType.number,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          final int? parsedValue = int.tryParse(value);
                          if (parsedValue == null) {
                            return "El Grado debe ser un número entero.";
                          } else if (parsedValue < 1 || parsedValue > 12) {
                            return "El Grado debe ser un número entre 1 y 12.";
                          }
                          return "Ingresa tu Grado";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DateTimeFormField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.event_note),
                        labelText: 'Fecha de Nacimiento',
                      ),
                      mode: DateTimeFieldPickerMode.date,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (e) =>
                          (e?.day ?? 0) == 1 ? 'Escoge una fecha válida' : null,
                      onDateSelected: (DateTime value) {
                        controllerDatebirth.text =
                            value.toLocal().toString().split(' ')[0];
                      },
                    ),
                    OutlinedButton(
                        onPressed: () async {
                          // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                          FocusScope.of(context).requestFocus(FocusNode());
                          final form = _formKey.currentState;
                          form!.save();
                          if (_formKey.currentState!.validate()) {
                            // put the logic of the button here.
                            print("entro!");
                            print(controllerSchool.text);
                            print(controllerGrade.text);
                            print(controllerDatebirth.text);
                            await _submitIntroForm(controllerSchool.text,
                                controllerGrade.text, controllerDatebirth.text);
                          }
                        },
                        child: const Text("Submit")),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  _submitIntroForm(String school, String grade, String datebirth) async {
    try {
      await userController.updateStudentInfo(school, grade, datebirth);
      Get.to(const SelectOperation());
    } catch (err) {
      Get.snackbar(
        "Error al enviar el formulario",
        err.toString(),
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
