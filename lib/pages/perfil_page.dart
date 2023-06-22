import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicar/models/models.dart';
import 'package:unicar/providers/login_from_provider.dart';
import 'package:unicar/services/auth_service.dart';
import 'package:unicar/services/user_service.dart';

//import '../widgets/custom_bottom_navigation.dart';

class PerfilesPage extends StatelessWidget {
  //const PerfilesPage({super.key});
  //final String id;
  final User? user;
  const PerfilesPage({super.key,  this.user});
  //final nameTextEditingController= TextEditingController() ;

  //const PerfilesPage({super.key});
  //final User? user;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final auth = Provider.of<AuthService>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.mode_edit_outline)),
            const Text('Perfil de Usuario')
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey[200],
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: screenHeight,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 22.0),
                              const Center(
                                child: CircleAvatar(
                                  radius: 100.0,
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.transparent,
                                  child: ClipOval(
                                    child: FadeInImage(
                                      placeholder:
                                          AssetImage('assets/jar-loading.gif'),
                                      image: NetworkImage(
                                          'https://via.placeholder.com/400x300/f6f6f6'),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                ),
                              ),

                              ////////////////////////
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 17.0,
                                ),
                                child: Center(
                                  child: Text(
                                    //ver como poner el nombre para mostrar
                                    //auth.name,
                                    //user!.name,
                                    'Jose carlos',
                                    //auth.usershow.name,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Center(
                                          child: Text(
                                            'Información Personal',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16.0),
                                        /*   _personalInfoRow(
                                          label1: 'Carnet de Identidad',
                                          value1: user!.carnet ?? 'No especificado',
                                          label2: 'Fecha de Nacimiento',
                                          value2: user!.fechaNac != null
                                              ? '${user!.fechaNac!.day}/${user!.fechaNac!.month}/${user!.fechaNac!.year}'
                                              : 'No especificada',
                                        ), */
                                        _personalInfoRow(
                                          label1: 'Teléfono',
                                          value1: '690621',
                                          //value1: auth.usershow.telefono,
                                          label2: 'Email',
                                          value2: 'jose@gmail.com'
                                          //value2: auth.usershow.email,
                                           //value2: auth.usershow.email,
                                          //user!.email,
                                        ),
                                        _personalInfoRow(
                                          label1: 'Numero de Registro',
                                          value1: '219001324',
                                          //value1: auth.usershow.registro.toString(),
                                          label2: 'Tipo de usuario',
                                          value2: 'ESTUDIANTE',
                                          // value2: auth.usershow.tipouser,
                                          //user!.email,
                                        ),
                                        const SizedBox(height: 8.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 100.0),
                            ],
                          ),
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
      floatingActionButton: FloatingActionButton.extended(onPressed: (){}, label: Text('registrar auto')),
    );
  }

  Widget _personalInfoRow({
    required String label1,
    required String value1,
    required String label2,
    required String value2,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _personalInfo(
            label: label1,
            value: value1,
          ),
          Flexible(
            child: _personalInfo(
              label: label2,
              value: value2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _personalInfo({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
