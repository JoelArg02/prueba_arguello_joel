import 'package:flutter/material.dart';
import 'package:prueba_arguello_joel/services/auth_service.dart';

class VerificationPage extends StatelessWidget {
  final String verificationId;
  final String name;
  final TextEditingController codeController = TextEditingController();

  VerificationPage({required this.verificationId, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verificar Código'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: 'Ingrese el código de verificación',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final smsCode = codeController.text;
                if (smsCode.isNotEmpty) {
                  AuthService().verifyCode(
                    verificationId,
                    smsCode,
                    name, // Pasamos el nombre para que se guarde en Firestore
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor, ingrese el código')),
                  );
                }
              },
              child: Text('Verificar'),
            ),
          ],
        ),
      ),
    );
  }
}
