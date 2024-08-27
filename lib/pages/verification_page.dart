import 'package:flutter/material.dart';
import 'package:prueba_arguello_joel/services/auth_service.dart';

class VerificationPage extends StatelessWidget {
  final String verificationId;
  final String name;
  final TextEditingController codeController = TextEditingController();

  VerificationPage({super.key, required this.verificationId, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificar Código'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                labelText: 'Ingrese el código de verificación',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final smsCode = codeController.text;
                if (smsCode.isNotEmpty) {
                  bool success = await AuthService().verifyCode(
                    verificationId,
                    smsCode,
                    name,
                  );

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('¡Código verificado con éxito!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('El código de verificación es incorrecto.')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor, ingrese el código')),
                  );
                }
              },
              child: const Text('Verificar'),
            ),
          ],
        ),
      ),
    );
  }
}
