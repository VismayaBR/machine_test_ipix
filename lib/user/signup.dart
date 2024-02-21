import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/constants/colors.dart';
import 'package:machine_test/widgets/AppText.dart';
import 'package:machine_test/widgets/customButton.dart';
import 'package:machine_test/widgets/customTextfield.dart';

class UserSignup extends StatefulWidget {
  UserSignup({super.key});

  @override
  State<UserSignup> createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  @override
  final username = TextEditingController();
  final phone = TextEditingController();
  var email = TextEditingController();
  var location = TextEditingController();
  final password = TextEditingController();
  final formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: customBalck,
              ))),
      backgroundColor: maincolor,
      body: Padding(
        padding: const EdgeInsets.only(left: 45, right: 45).r,
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 70).r,
                    child: Image.asset(
                      "assets/logo.png",
                      width: 140.w,
                      height: 140.h,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  const AppText(
                      text: "SIGN UP",
                      weight: FontWeight.w700,
                      size: 23,
                      textcolor: customBalck),
                  SizedBox(
                    height: 50.h,
                  ),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: AppText(
                        text: "Enter Username",
                        weight: FontWeight.w500,
                        size: 16,
                        textcolor: customBalck),
                  ),
                  CustomTextField(
                      //Custom Textfield..............
                      hint: "Enter Username",
                      controller: username,
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return "enter username";  // validation............
                        }
                      }),
                      CustomTextField(
                      //Custom Textfield..............
                      hint: "Enter location",
                      controller: location,
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return "enter username";  // validation............
                        }
                      }),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: AppText(
                        text: "Enter Phone number",
                        weight: FontWeight.w500,
                        size: 16,
                        textcolor: customBalck),
                  ),
                  CustomTextField(
                      hint: "Enter Phone number",
                      controller: phone,
                      kebordtype: TextInputType.number,
                      validator: (value) {
                        if (value?.length != 10) {      // validation............
                          return 'Please enter mobile number';
                        }
                      }),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: AppText(
                        text: "Enter your email",
                        weight: FontWeight.w500,
                        size: 16,
                        textcolor: customBalck),
                  ),
                  CustomTextField(
                      hint: "Enter your email",
                      controller: email,
                      kebordtype: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {  // validation............
                          return 'Enter a valid email!';
                        }
                      }),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: AppText(
                        text: "Enter your password",
                        weight: FontWeight.w500,
                        size: 16,
                        textcolor: customBalck),
                  ),
                  CustomTextField(
                      hint: "Enter your password",
                      obscure: true,
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return "enter password";   // validation............
                        }
                      }),
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, bottom: 30)
                            .r,
                    child: CustomButton(
                        //sign up button.......
                        btnname: "SIGN UP",
                        btntheam: customBlue,
                        textcolor: white,
                        click: () {
                          formkey.currentState!.validate();
                          // signUp();
                        }),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
  // Future<void> signUp() async {
  //   print('.........................');
  //   await FirebaseFirestore.instance.collection('users').add({
  //     'username': username.text,
  //     'phone': phone.text,
  //     'email': email.text,
  //     'password': password.text,
  //     'status':'0',
  //     'location':location.text
  //   });
  //   Navigator.pop(context);
  //   // username.clear();
  //   // phone.clear();
  //   // email.clear();
  //   // experience.clear();
  //   // workshop.clear();
  //   // password.clear();
  // }
}
