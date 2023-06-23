import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '../../home/home.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class VerifactionPhone extends StatefulWidget {
  final String phone;
  final String codeDigits;

  VerifactionPhone({required this.phone, required this.codeDigits, Key? key})
      : super(key: key);

  @override
  State<VerifactionPhone> createState() => _VerifactionPhoneState();
}

class _VerifactionPhoneState extends State<VerifactionPhone> {
  final TextEditingController _pinOTPController = TextEditingController();
  final FocusNode _pinOTPcodeFocus = FocusNode();
  String? verificationCode;

  bool isCodeCorrect = false;

  @override
  void initState() {
    super.initState();
    verifyPhoneNumber();
  }

  verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "${widget.codeDigits} ${widget.phone}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          if (value.user != null) {
            setState(() {
              isCodeCorrect = true;
            });
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid OTP'),
            duration: Duration(seconds: 3),
          ),
        );
        print(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          verificationCode = verificationId;
        });
      },
      timeout: Duration(seconds: 60),
    );
  }

  void submitPin(String pin) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationCode!,
          smsCode: pin,
        ),
      )
          .then((value) {
        if (value.user != null) {
          setState(() {
            isCodeCorrect = true;
          });
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid OTP'),
          duration: Duration(seconds: 3),
        ),
      );
      print(e);
    }
  }

  static const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
  static const fillColor = Color.fromRGBO(243, 246, 249, 0);
  static const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

  final defaultPinTheme = PinTheme(
    width: 40,
    height: 40,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: borderColor),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
              alignment: Alignment.center,
              child: Lottie.asset('assets/lottie/verify.json'),
            ),
            Container(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    verifyPhoneNumber();
                  },
                  child: Text('Verify: ${widget.codeDigits} ${widget.phone}'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Pinput(
                onSubmitted: (pin) {
                  submitPin(pin);
                },
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
                length: 6,
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
              color: Colors.orange.shade300,
              onPressed: () {
                Get.to(Home());

                // if (isCodeCorrect) {
                //   Get.to(Home());
                // } else {
                //   verifyPhoneNumber();
                // }
              },
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 0,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17)),
              child: Container(
                child: Text(
                  'Verifier',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
