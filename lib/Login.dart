import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:machine_test/admin/AdminHome.dart';
import 'package:machine_test/constants/colors.dart';
import 'package:machine_test/user/UserHome.dart';
import 'package:machine_test/user/signup.dart';
import 'package:machine_test/widgets/AppText.dart';
import 'package:machine_test/widgets/customButton.dart';
import 'package:machine_test/widgets/customTextfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  var userId;
  var type;

  @override
  void initState() {
    super.initState();
    // Initialize controllers if needed
    usernameController.text = '';
    passwordController.text = '';
  }

  void login(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      // Simulate a delay for login (Replace with your actual login logic)
      await Future.delayed(Duration(seconds: 1));

      setState(() {
        isLoading = false;
      });

      final QuerySnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('username', isEqualTo: usernameController.text)
              .where('password', isEqualTo: passwordController.text)
              .get();

      if (userSnapshot.docs.isNotEmpty) {
        setState(() {
          userId = userSnapshot.docs[0].id;
          type = userSnapshot.docs[0]['type'];
        });

        // print('.................$mechId');
        SharedPreferences spref = await SharedPreferences.getInstance();
        spref.setString('user_id', userId);
        
        if (type == 'admin') {
          Fluttertoast.showToast(msg: 'Login Successful as Admin');
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return AdminHome();
          }));
        }
        if (type == 'user') {
          Fluttertoast.showToast(msg: 'Login Successful as User');
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return UserHome();
          }));
        }
      } else {
        // Show an error message to the user
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid username or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside text fields
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: maincolor,
        body: Padding(
          padding: EdgeInsets.only(left: 45, right: 45, top: 10).r,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 80, bottom: 50).r,
                    child: Image.asset(
                      "assets/logo.png",
                      width: 140.w,
                      height: 140.h,
                    ),
                  ),
                  const AppText(
                    text: "LOGIN",
                    weight: FontWeight.w700,
                    size: 23,
                    textcolor: customBalck,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: AppText(
                      text: "Enter Email",
                      weight: FontWeight.w500,
                      size: 16,
                      textcolor: customBalck,
                    ),
                  ),
                  CustomTextField(
                    hint: "Email",
                    controller: usernameController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter  Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: AppText(
                      text: "Enter Password",
                      weight: FontWeight.w500,
                      size: 16,
                      textcolor: customBalck,
                    ),
                  ),
                  CustomTextField(
                    hint: "password",
                    controller: passwordController,
                    obscure: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a password';
                      }
                      // Check if the password meets your criteria
                      if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$').hasMatch(value!)) {
                        return 'Password must contain at least one alphabet and one number, and be at least 6 characters long.';
                      }
                      return null;
                    },
                  ),
                  
                  SizedBox(
                    height: 80.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 50, right: 50).r,
                    child: CustomButton(
                      btnname: isLoading ? "Logging In..." : "LOGIN",
                      btntheam: customBlue,
                      textcolor: white,
                      click: () {
                      login(context);
                    },
                    ),
                  ),
                   SizedBox(
                  height: 20.w,
                ),
                  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppText(
                    text: "Do you have account ?",
                    weight: FontWeight.w400,
                    size: 13,
                    textcolor: customBalck),
                SizedBox(
                  width: 10.w,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserSignup(),
                        )); // SignUp ..................................
                  },
                  child: const AppText(
                      text: "Sign up",
                      weight: FontWeight.w400,
                      size: 13,
                      textcolor: customBlue),
                )
              ],
            ),
                 ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
