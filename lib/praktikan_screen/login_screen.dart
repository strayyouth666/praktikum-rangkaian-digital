// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcare_web/aslab_screen/aslab_home_screen.dart';
import 'package:smartcare_web/reusable/custom_input.dart';
import 'package:smartcare_web/reusable/project_colors.dart';
import 'package:smartcare_web/reusable/scroll_widget.dart';
import 'package:smartcare_web/praktikan_screen/home_screen.dart';
import 'package:smartcare_web/praktikan_screen/signup_screen.dart';
import 'package:smartcare_web/system/authentication.dart';
// import 'package:smartcare_web/screen/home_screen.dart';
// import 'package:smartcare_web/system/login_request.dart';
// import 'package:smartcare_web/system/signupDB.dart';
import 'dart:js' as js;
import 'dart:html';

import '../reusable/validators.dart';
import '../system/encrypt_decrypt.dart';
import '../system/loginDB.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController,
      passwordController,
      forgotPasswordController;
  late FocusNode textFocusNodeEmail;
  final User? user = Authentication().currentUser;
  String result = '';
  bool _isEditingEmail = false;
  bool rememberMe = false, isRequestingAuth = false, isLogin = false;

  String? _validateEmail(String value) {
    value = value.trim();

    if (emailController.text.isNotEmpty) {
      if (value.isEmpty) {
        return 'Email can\'t be empty';
      } else if (!value.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return 'Enter a correct email address';
      }
    }
    return null;
  }

  Future<void> signOut() async {
    Authentication().signOut();
  }

  Widget userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text("Sign Out"),
    );
  }

  // Future<void> logInMysql () async {
  //   if(emailController.text.isEmpty){
  //     if(emailController.text.toLowerCase().contains('@'.toLowerCase()) &&
  //     emailController.text.toLowerCase().contains('.com'.toLowerCase())) {
  //       if(passwordController.text.isNotEmpty) {
  //         if(passwordController.text.length > 3) {
  //           LoginDB(
  //             password: passwordController.text,
  //             email: emailController.text,
  //           ).login().then((value) {
  //             print('Login Status: $value');
  //           });
  //         } else {
  //           ScaffoldMessenger.of(context)
  //               .showSnackBar(const SnackBar(
  //             backgroundColor: ProjectColors.red,
  //             content: Text("Your Password Too Short"),));
  //         }
  //       } else {
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(const SnackBar(
  //           backgroundColor: ProjectColors.red,
  //           content: Text("Enter Password"),));
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(const SnackBar(
  //         backgroundColor: ProjectColors.red,
  //         content: Text("Invalid Email"),));
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(
  //       backgroundColor: ProjectColors.red,
  //       content: Text("Enter Email"),));
  //   }
  // }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Authentication().signInWithEmailPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        Validators.invalidEmailError = e.message!;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Authentication().registerWithEmailPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        Validators.invalidEmailError = e.message!;
      });
    }
  }

  // Widget newSubmitButton(){
  //   return MaterialButton(
  //     color: Colors.blue.shade900,
  //     onPressed: logInMysql,
  //     child: const Text("Login", style: TextStyle(color: Colors.white),),
  //   );
  // }

  Widget submitButton() {
    return MaterialButton(
      color: Colors.blue.shade900,
      onPressed: (() {
        if (emailController.text == "praktikan@app.com") {
          Get.to(const HomeScreen());
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: ProjectColors.green,
              content: Text("Login Successfull.")));
        } else if (emailController.text == "aslab@app.com") {
          Get.to(const AslabHomeScreen());
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: ProjectColors.green,
              content: Text("Login Successfull.")));
        } else if (emailController.text == "admin@app.com") {
          Get.to(const HomeScreen());
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: ProjectColors.green,
              content: Text("Login successfull.")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: ProjectColors.red,
              content: Text(
                  "The combination you have entered does not match any credentials.")));
        }
      }),
      // signInWithEmailAndPassword,
      child: const Text(
        "Login",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget loginOrRegisterButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? "register instead" : "login instead"));
  }

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController(text: "praktikan@app.com");
    textFocusNodeEmail = FocusNode();
    passwordController = TextEditingController();
    forgotPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    forgotPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginFormKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: ProjectColors.darkBlack,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 330),
          decoration: BoxDecoration(
              color: ProjectColors.lightBlack,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 3), color: Colors.white, blurRadius: 10.0)
              ]),
          clipBehavior: Clip.hardEdge,
          child: ScrollWidget(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("PRAKTIKUM KOMPUTER ITS",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              decoration: TextDecoration.none)),
                      SizedBox(
                        height: 10,
                      ),
                      // Image.asset('lib/assets/Rectangle 2.png',
                      //     // width: 500,
                      //     height: 200),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: ProjectColors.lightBlack,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 3),
                                    color: Colors.black.withOpacity(.1),
                                    blurRadius: 10.0)
                              ]),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: 300,
                            child: Form(
                              key: loginFormKey,
                              child: Column(children: [
                                CustomInput(
                                  hint: "Email",
                                  label: "Email",
                                  controller: emailController,
                                  validator: (val) {
                                    final validator = Validators(value: val!);

                                    if (val.isEmpty) {
                                      return Validators.emptyValueError;
                                    }

                                    return validator.emailValidator();
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    CustomInput(
                                      hint: "Password",
                                      label: "Password",
                                      obscureText: true,
                                      showSeekButton: true,
                                      controller: passwordController,
                                      validator: (val) {
                                        final validator =
                                            Validators(value: val!);

                                        return validator
                                            .nonEmptyValueValidator();
                                      },
                                    ),
                                  ],
                                ),
                              ]),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(child: submitButton()),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: ProjectColors.lightBlack,
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Text.rich(TextSpan(
                            style: const TextStyle(color: Colors.white),
                            children: [
                              const TextSpan(text: "Not registered yet? "),
                              TextSpan(
                                  text: "Register",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(const SignUpScreen());
                                    }),
                              const TextSpan(text: " now"),
                            ])),
                      ),
                    ),

                    // Column(
                    //   children: [
                    //     //     MaterialButton(
                    //     //     color: Colors.blueAccent,
                    //     //     onPressed: () async {
                    //     //       result = await
                    //     //       DatabaseRequest(
                    //     //         email: emailController.text,
                    //     //         password: passwordController.text,
                    //     //       ).request();
                    //     //       setState(() {});
                    //     //     },
                    //     //     child: const Text(
                    //     //       "Login Now",
                    //     //       style: TextStyle(
                    //     //         color: Colors.white,
                    //     //       ),
                    //     //     ),
                    //     // ),

                    //   ],
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
