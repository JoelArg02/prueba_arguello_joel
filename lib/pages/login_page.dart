import 'package:flutter/material.dart';
import 'package:prueba_arguello_joel/services/auth_service.dart';
import 'package:prueba_arguello_joel/pages/verification_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Ingrese su nombre',
              ),
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 20),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Ingrese su número de teléfono',
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final phoneNumber = phoneController.text;

                if (name.isNotEmpty && phoneNumber.isNotEmpty) {
                  AuthService().sendVerificationCode(
                    phoneNumber,
                    (verificationId) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => VerificationPage(
                            verificationId: verificationId,
                            name: name,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  // Muestra un mensaje si los campos están vacíos
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor, complete todos los campos')),
                  );
                }
              },
              child: Text('Enviar Código'),
            ),
          ],
        ),
      ),
    );
  }
}
