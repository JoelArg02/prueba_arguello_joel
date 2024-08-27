import 'package:flutter/material.dart';
import 'package:prueba_arguello_joel/services/auth_service.dart';
import 'package:prueba_arguello_joel/pages/verification_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Ingrese su nombre',
              ),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Ingrese su número de teléfono',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final phoneNumber = formatPhoneNumber(phoneController.text);

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
                    const SnackBar(content: Text('Por favor, complete todos los campos')),
                  );
                }
              },
              child: const Text('Enviar Código'),
            ),
          ],
        ),
      ),
    );
  }

  String formatPhoneNumber(String input) {
    String cleaned = input.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleaned.startsWith('0')) {
      cleaned = '+593' + cleaned.substring(1);
    }

    return cleaned;
  }
}
