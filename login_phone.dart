import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:instatalk/view/screens/auth/phone/verif_phone.dart';

import '../../../customs/customtext.dart';

class LoginPhone extends StatefulWidget {
  const LoginPhone({super.key});

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  String dialCodeDigits = '+00';
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String number;
    String smsCode;
    String verificationCode;
    return ProgressHUD(
      child: Builder(
        builder: (context) => Scaffold(
          body: // Set a fixed height or use other constraints

              SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 90,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 70, 0, 25),
                alignment: Alignment.center,
                child: CustomText(
                  textcontent: "InstaTalk",
                  fontsize: 35,
                  textcolor: Colors.blueAccent,
                  textalign: TextAlign.center,
                  fontweight: FontWeight.bold,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: CustomText(
                  textcontent:
                      "Veuillez confirmer votre code pays et \n entrer votre numéro de téléphone.",
                  fontsize: 15,
                  textcolor: Colors.grey.shade700,
                  textalign: TextAlign.center,
                  fontweight: FontWeight.w400,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 30),
                alignment: Alignment.center,
                child: CustomText(
                  textcontent: "Votre numéro de téléphone",
                  fontsize: 20,
                  textcolor: Colors.black,
                  textalign: TextAlign.center,
                  fontweight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              CountryCodePicker(
                onChanged: (country) {
                  setState(() {
                    dialCodeDigits = country.dialCode!;
                  });
                },
                initialSelection: 'US',
                favorite: ['+212', 'MA'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(17, 0, 17, 0),
                child: TextFormField(
                  controller: _controller,
                  onChanged: (value) {
                    number = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'phone number',
                    prefix: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(dialCodeDigits)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 10),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              MaterialButton(
                color: Color(0xFF617BF1),
                onPressed: () async {
                  Get.to(VerifactionPhone(
                      phone: _controller.text, codeDigits: dialCodeDigits));
                  final progress = ProgressHUD.of(context);
                  progress!.show();

                  await Future.delayed(Duration(seconds: 4), () {});

                  // Dismiss the loading indicator
                  progress.dismiss();
                },
                padding: const EdgeInsets.symmetric(
                  horizontal: 120,
                  vertical: 0,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
