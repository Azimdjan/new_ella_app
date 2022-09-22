import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../router/name_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
              Text("Login Page"),
              ElevatedButton(
                onPressed: () {
                  context.go(Routes.register);
                },
                child: Text("To Register page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
