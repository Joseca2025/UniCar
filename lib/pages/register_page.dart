import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:unicar/providers/login_from_provider.dart';
import 'package:unicar/services/auth_service.dart';
import 'package:unicar/widgets/widgets.dart';

import '../ui/input_decorations.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        body: AuthBackgroup(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250),
              CardContainer(
                  child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Crear una cuenta',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: 30),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvide(),
                    child: _LoginForm(),
                  ),
                  // _LoginForm()
                ],
              )),
              SizedBox(height: 50),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'login'),
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Colors.blueAccent.withOpacity(0.1)),
                    shape: MaterialStateProperty.all(StadiumBorder())),
                child: Text(
                  '¿Ya tienes una cuenta? ',
                  style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        )));
  }
}

class _LoginForm extends StatelessWidget {
  // const _LoginForm({super.key});
  String? selectedUser;
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvide>(context);
    return Container(
      child: Form(
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Correo@gmail.com',
                    labelText: 'Correo electronico',
                    prefixIcon: Icons.alternate_email),
                onChanged: (value) => loginForm.email = value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'El valor ingresado no un correro';
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '******',
                    labelText: 'Contraseña',
                    prefixIcon: Icons.lock_clock_outlined),
                onChanged: (value) => loginForm.password = value,
                validator: (value) {
                  if (value != null && value.length >= 8) return null;
                  return 'La contraseña debe ser mayor a 7 caracteres';
                },
              ),
              SizedBox(
                height: 30,
              ),

              //tendria que ir debajo de esto
              TextFormField(
                autocorrect: false,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nombre',
                    labelText: 'Nombre',
                    prefixIcon: Icons.person_2_outlined),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                autocorrect: false,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Apellido completo',
                    labelText: 'Apellido',
                    prefixIcon: Icons.person_2_outlined),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                autocorrect: false,
                obscureText: false,
                keyboardType:
                    TextInputType.phone, // Configuración para teclado numérico
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Número de teléfono',
                  labelText: 'Teléfono',
                  prefixIcon: Icons.phone_outlined,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                autocorrect: false,
                obscureText: false,
                keyboardType:
                    TextInputType.phone, // Configuración para teclado numérico
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Número de registro',
                  labelText: 'Registro',
                  prefixIcon: Icons.numbers_outlined,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Seleccione un usuario',
                  labelText: 'Tipo de usuario',
                  prefixIcon: Icons.person,
                ),
                value:
                    selectedUser, // Valor seleccionado (ESTUDIANTE o CONDUCTOR)
                onChanged: (String? newValue) {
                  // Actualizar el valor seleccionado
                  selectedUser = newValue;
                },
                items: <String>['ESTUDIANTE', 'CONDUCTOR'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 30),

              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.white,
                  elevation: 0,
                  color: Colors.blueAccent,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      child: Text(
                        loginForm.isLoading ? 'Espere' : 'Registrar',
                        style: TextStyle(color: Colors.white),
                      )),
                  onPressed: loginForm.isLoading
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();
                          final authService =
                              Provider.of<AuthService>(context, listen: false);
                          if (!loginForm.isValidForm()) return;
                          loginForm.isLoading = true;
                          //await Future.delayed(Duration(seconds: 2));
                          //TODO: validar si el login es correcto
                          final String? errorMessage = await authService
                              .createUser(loginForm.email, loginForm.password);

                          if (errorMessage == null) {
                            Navigator.pushReplacementNamed(context, 'home');
                          } else {
                            //mostrar error en pantalla
                            print(errorMessage);
                            loginForm.isLoading = false;
                          }
                        })
            ],
          )),
    );
  }
}
