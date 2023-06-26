import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcare_web/reusable/custom_input.dart';
import 'package:smartcare_web/reusable/project_colors.dart';
import 'package:smartcare_web/system/authentication.dart';
import 'package:smartcare_web/praktikan_screen/home_screen.dart';
import 'package:smartcare_web/system/login_request.dart';
import 'package:smartcare_web/system/signupDB.dart';
import 'dart:js' as js;
import 'dart:html';
import '../reusable/scroll_widget.dart';
import '../reusable/validators.dart';
import '../system/encrypt_decrypt.dart';
import '../system/loginDB.dart';
import 'login_screen.dart';
import '../system/api_mysql.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController emailController,
      passwordController,
      confirmController,
      nameController,
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

  // Future<void> signOut() async {
  //   Authentication().signOut();
  // }

  // Widget userUid(){
  //   return Text(user?.email ?? 'User email');
  // }

  // Widget signOutButton(){
  //   return ElevatedButton(
  //     onPressed: signOut,
  //     child: const Text("Sign Out"),
  //   );
  // }

  // Future<void> signUp() async{
  //   if(emailController.text.isEmpty){
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(
  //       backgroundColor: ProjectColors.green,
  //       content: Text("Enter Email"),));
  //   } else if (passwordController.text.isEmpty){
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(
  //       backgroundColor: ProjectColors.green,
  //       content: Text("Enter Password"),));
  //   } else if (nameController.text.isEmpty) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(
  //       backgroundColor: ProjectColors.green,
  //       content: Text("Enter Username"),));
  //   }
  //   // else if (referController.text.isEmpty) {
  //   //   ScaffoldMessenger.of(context)
  //   //       .showSnackBar(const SnackBar(
  //   //     backgroundColor: ProjectColors.green,
  //   //     content: Text("Enter Confirm Password"),));
  //    else {
  //     RegisterDB(
  //       email: emailController.text,
  //       password: passwordController.text,
  //       name: nameController.text,
  //       // upliner: referController.text,
  //     ).register().then((value) {
  //       print('Response: $value');
  //     });
  //   }
  // }

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

  Widget submitButton() {
    return MaterialButton(
      color: Colors.blue.shade900,
      onPressed: () {
        Get.to(const LoginScreen());
      },
      // createUserWithEmailAndPassword,
      child: const Text(
        "Register",
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

    emailController = TextEditingController();
    nameController = TextEditingController();
    confirmController = TextEditingController();
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
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 3),
                    color: Colors.white,
                    blurRadius: 10.0)
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
                                CustomInput(
                                  hint: "Username",
                                  label: "Username",
                                  controller: nameController,
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
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    CustomInput(
                                      hint: "Confirm Password",
                                      label: "Confirm Password",
                                      obscureText: true,
                                      showSeekButton: true,
                                      controller: confirmController,
                                      validator: (val) {
                                        final validator =
                                            Validators(value: val!);

                                        return validator
                                            .nonEmptyValueValidator();
                                      },
                                    ),
                                  ],
                                )
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
                              const TextSpan(text: "Already registered? "),
                              TextSpan(
                                  text: "Login",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(const LoginScreen());
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
