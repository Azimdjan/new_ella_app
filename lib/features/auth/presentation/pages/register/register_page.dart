import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../router/name_routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  void dispose() {
    debugPrint("Login disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text("Register Page"),
              ElevatedButton(
                onPressed: () {
                  context.go(Routes.login);
                },
                child: Text("To Login page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
