import 'package:flutter/src/widgets/framework.dart';
import 'register_page.dart';
import 'login_mail.dart';

class AuthMail extends StatefulWidget {
  const AuthMail({super.key});

  @override
  State<AuthMail> createState() => AuthMailState();
}

class AuthMailState extends State<AuthMail> {
  bool showLoginPage = true;
  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoginPage
        ? LoginMail(
            showRegisterPage: toggleScreen,
          )
        : RegisterMail(
            showLoginPage: toggleScreen,
          );
  }
}
