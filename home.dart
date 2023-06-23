import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instatalk/view/screens/home/mode/private_mode.dart';
import 'package:instatalk/view/screens/home/mode/public_mode.dart';
import '../../../controller/auth_controller.dart';
import '../../../core/function/class/custom_clipperpath.dart';

AuthController controller = Get.find();

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final user_email = FirebaseAuth.instance.currentUser!;
    // final user_phone = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipPath(
              clipper: CustomClipperPath(),
              child: Container(
                color: Color(0xFF617BF1),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 180),
                      child: Text(
                        " InstaTalk",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(140, 0, 140, 60),
                        alignment: Alignment.center,
                        child: Image.asset('assets/logo.jpg'))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(PublicMode(
                      chatId: '',
                      contactEmail: '',
                    ));
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      backgroundColor: MaterialStatePropertyAll(
                        Color(0xFF617BF1),
                      ),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.fromLTRB(30, 10, 30, 10))),
                  child: Text(
                    'Mode standard', // option
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(PrivateMode());
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    // shape: MaterialStateProperty.all(CircleBorder()),
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(50, 10, 50, 10)),
                  ),
                  child: Text(
                    'Mode privé',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // Text("Signed In as : " + user_email.email!),
                Text("Signed In as : " + user_email.email!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
