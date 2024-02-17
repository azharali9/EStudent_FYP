
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/auth/sign_up_screen.dart';

import '../utils/colors.dart';
import '../utils/component/buttoncontainer.dart';
import '../utils/global.dart';
import '../utils/sizeconfig.dart';
import '../utils/sizes_class.dart';
import '../view/homeScreen.dart';
import 'auth_controller.dart';
import 'component/containetetfeild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    MySize2().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        // leading:GestureDetector(
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //     child: Icon(
        //       Icons.close,
        //       color: Colors.black,
        //       size: 20,
        //     )),


        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignUpScreen()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  'Sign Up',
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

        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 5,),

              Text(
                'Sign In',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: MySize2.size20 , color: Colors.white),
              ),
              Text(
                'Enter Your Registered Email & Password to Continue ',

                // textAlign: TextAlign.center,
                style:TextStyle(fontSize:MySize2.size10, fontWeight: FontWeight.w400 , color: Colors.white),),
              SizedBox(height: 5,),

              SizedBox(height: height(context)* 0.02,),
              ContainerTextField2(
                controller: emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              // SizedBox(height: height(context)* 0.005,),
              ContainerTextField2(
                controller: passwordController,
                hintText: 'Password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),


              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: (){
                    showReset(context);
                    // showModalBottomSheet(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return ResetPasswordBottomSheet();
                    //   },
                    // );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                    // );
                  },
                  child: Text(
                      'Reset Password',
                      //   textAlign: TextAlign.end,
                      style: TextStyle(fontSize: MySize2.size12, fontWeight: FontWeight.w400,color: primaryColor)
                  ),
                ),
              ),
              SizedBox(height: 8,),
              SizedBox(height: 5,),

              MyButtonContainer(
                containerColor: primaryColor,
                textColor: Colors.white,
                onTap: () async {




                  ///
                  showLoadingDialog(context);
                  final UserCredential? userCredential = await authService
                      .signInWithEmail(context, emailController.text, passwordController.text);
                  if (userCredential != null) {

                    // Authentication successful, navigate to the next screen
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }
                  // Your onTap logic

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => HomeScreen()),
                  // );

                },
                buttonText: 'Sign In',
              ),


              SizedBox(height: 5,),
              // const Text.rich(
              //   TextSpan(
              //     children: [
              //       TextSpan(
              //         text: 'Please read our ',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 12,
              //           fontFamily: 'Poppins',
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //       TextSpan(
              //         text: 'Terms & Conditions',
              //         style: TextStyle(
              //           color: primaryColor,
              //           fontSize: 12,
              //           fontFamily: 'Poppins',
              //           fontWeight: FontWeight.w400,
              //           decoration: TextDecoration.underline,
              //
              //         ),
              //       ),
              //     ],
              //   ),
              //   textAlign: TextAlign.center,
              // )
            ],
          ),
        ),
      ),
    );
  }
  void showReset(BuildContext context) {
    TextEditingController emailController1 = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pngwing.com%2Fen%2Ffree-png-ygxss&psig=AOvVaw13hBXpekhYUFVUEMdBMUTF&ust=1702055423420000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCMDj3-Tz_YIDFQAAAAAdAAAAABAD', height: MySize2.size245),
                  SizedBox(height: MySize2.size30),
                  const Text(
                    'Hit the reset button and reclaim your account securely. Activity App makes password recovery a breeze for a worry-free experience.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF9F9F9F),
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: MySize2.size30),
                  ContainerTextField2(
                    controller: emailController1,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: MySize2.size30),
                  MyButtonContainer(
                    containerColor: primaryColor,
                    textColor: Colors.white,
                    onTap: () async {
                      AuthService authService = AuthService();
                      // var checkUser =await  getUserType(emailController1.text);
                      // print(checkUser);
                      authService.resetPassword(emailController1.text);
                      Navigator.pop(context); // Close the dialog
                    },
                    buttonText: 'Reset',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
