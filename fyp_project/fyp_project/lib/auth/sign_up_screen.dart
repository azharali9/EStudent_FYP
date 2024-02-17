
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/component/buttoncontainer.dart';
import '../../utils/component/snackbar.dart';
import '../../utils/global.dart';
import '../../utils/padding_screen.dart';
import '../../utils/sizeconfig.dart';
import '../../utils/textstyle.dart';
import '../view/homeScreen.dart';
import 'auth_controller.dart';
import 'component/containetetfeild.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameCon = TextEditingController();
  final TextEditingController contactCon = TextEditingController();
  final TextEditingController createPasswordCon = TextEditingController();
  final TextEditingController confirmPasswordCon = TextEditingController();

  final TextEditingController batchCon = TextEditingController();
  final TextEditingController rollNoCon = TextEditingController();

  final RegExp _emailRegExp =
  RegExp(r'^[a-zA-Z0-9.-]+@nu\.edu\.pk$', caseSensitive: false);

  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close, color: Colors.white, size: 25)),

        title: const Text(
          'Register',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),

        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);

            },
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  'Sign In',
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContainerTextField2(
                  controller: fullNameCon,
                  hintText: 'Full Name',
                  keyboardType: TextInputType.name,
                  //  obscureText: true,
                ),
                SizedBox(height: height(context) * 0.02),
                const Text(
                  'Only Accepts your nu Email',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: height(context) * 0.02),
                ContainerTextField2(
                  controller: emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: height(context) * 0.02),
                const Text(
                  'Roll number Format (18i-1234) Write your batch in first box and the number after i in second',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: height(context) * 0.01),
                Row(
                  children: [
                    Container(
                      width: 150,
                      child: ContainerTextField2(
                        controller: batchCon,
                        hintText: 'Batch',
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text('--'),
                    ),
                    Container(
                      width: 150,
                      child: ContainerTextField2(
                        controller: rollNoCon,
                        hintText: 'Roll Number',
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height(context) * 0.02),
                ContainerTextField2(
                  controller: createPasswordCon,
                  hintText: 'Create Passwoord',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                SizedBox(
                  height: height(context) * 0.02,
                ),
                const Text(
                  'password as unique as you are your gateway to secure and seamless access.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.01,
                ),
                ContainerTextField2(
                  controller: confirmPasswordCon,
                  hintText: 'Confirm Passwoord',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                SizedBox(
                  height: height(context) * 0.05,
                ),
                Column(
                  children: [
                    MyButtonContainer(
                      containerColor: primaryColor,
                      textColor: Colors.white,
                      onTap: () async {
                        // Your onTap logic
                         var isEmailValid =
                            _emailRegExp.hasMatch(emailController.text.trim());

                        if(isEmailValid){
                         if (createPasswordCon.text == confirmPasswordCon.text) {
                           showLoadingDialog(context);
                           final UserCredential? userCredential =
                           await _authService.signUpWithEmail(
                               context,
                               emailController.text,
                               confirmPasswordCon.text);
                           if (userCredential != null) {
                             _authService.setData(
                                 fullNameCon.text,
                                 emailController.text,
                                 batchCon.text,
                                 rollNoCon.text,

                                 context);
                             FirebaseAuth.instance.signOut();
                             Navigator.pop(context);
                             Navigator.pushReplacement(context,
                                 MaterialPageRoute(builder: (context) => LoginScreen()));
                           }
                         } else {
                           show(context, 'Password does not match');
                         }
                       }else{
                          show(context, 'Invlide email');

                        }

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => JoinUsScreen()),
                        // );
                      },
                      buttonText: 'Sign Up',
                    ),

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
