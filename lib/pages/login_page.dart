import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:unicar/providers/login_from_provider.dart';
import 'package:unicar/widgets/widgets.dart';

import '../ui/input_decorations.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Inisiar Sesion',
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
          Text(
            'crear una nueva cuanta ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 50),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  // const _LoginForm({super.key});

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
                onChanged: (value) => loginForm.correo = value,
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
                onChanged: (value) => loginForm.contrasena = value,
                validator: (value) {
                  if (value != null && value.length >= 8) return null;
                  return 'La contraseña debe ser mayor a 7 caracteres';
                },
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.blueAccent,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      child: Text(
                        'Ingresar',
                        style: TextStyle(color: Colors.white),
                      )),
                  onPressed: () {
                    if (!loginForm.isValidForm()) return;
                    Navigator.pushReplacementNamed(context, 'home');
                  })
            ],
          )),
    );
  }
}
