import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  late final AuthService service  = AuthService();

  late bool _isLogIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            border:BorderDirectional(top: BorderSide(width: 80)),
            color: Colors.black54
        ),
        child: Form(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Icon(
                    Icons.bookmark,
                    size: 72,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  Text(
                    "Sept Jours",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text("by Alura and Rick",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 36, horizontal: 18),
                    child: Divider(thickness: 3, color: Colors.black87),
                  ),
                  Text(
                      "WELCOME",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      label: Text(
                        "Email",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(label: Text("Password",
                      style: Theme.of(context).textTheme.bodyMedium,)),
                    keyboardType: TextInputType.visiblePassword,
                    maxLength: 16,
                    obscureText: true,
                  ),
                  loginDynamic(context),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginDynamic(BuildContext context) {
    return InkWell(
        onTap: (){
          (_isLogIn)
              ? login(context)
              : signup(context);
        },
        onLongPress: () {
          setState(() {
            _isLogIn = !_isLogIn;
          });
        },
        child: Container(
          width: 70,
          height: 70,
          decoration: ShapeDecoration(
              shape: const CircleBorder(
                  side: BorderSide(width: 1.0,
                      color: Colors.black87
                  ),
              ),
              color: (_isLogIn)
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary.withRed(15)
          ),
          child: Center(
            child: Text(
              (_isLogIn)
                  ? "Login"
                  : "Signup",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        )
    );

  }

  login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text; // is this safe?

    try {
      await service.login(email: email, password: password).then(
              (_) {
                QuickAlert.show(
                    context: context,
                    type: QuickAlertType.info,
                    text: "logged in"
                );
                Navigator.pushNamed(context, "home");
              }
      );
    } on HttpException {
      QuickAlert.show(context: context, type: QuickAlertType.info, text: "You failed.");
    }

  }

  signup(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text; // is this safe?

    try {
      await service.signup(email: email, password: password).then(
              (value) => QuickAlert.show(
              context: context,
              type: QuickAlertType.info,
              text: "signed up"
          )
      );
    } on HttpException {
      QuickAlert.show(context: context, type: QuickAlertType.info, text: "You failed.");
    }

  }
}