import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/component/snackbar.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up with email and password
  // Sign up with email and password
  Future<UserCredential?> signUpWithEmail(BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } catch (e) {
      if (e is FirebaseAuthException) {
        String errorMessage = '';
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'Invalid email address.';
            break;
          case 'user-not-found':
            errorMessage = 'User not found. Please sign up.';
            break;
          case 'wrong-password':
            errorMessage = 'Invalid password.';
            break;
          case'email-already-in-use':
            errorMessage = 'The email address is already in use by another account.';
            break;
        // Add more cases as per your requirements
          default:
            errorMessage = 'An error occurred. Please try again later.';
        }
        Navigator.pop(context);

        _showErrorDialog(context, errorMessage);

      } else {
        if (kDebugMode) {
          print('Error signing in and out: $e');
        }
        // Handle other types of exceptions or unknown errors
      }
      print('Error signing up with email and password: $e');
      return null;
    }
  }

  void _showErrorDialog(BuildContext context,String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Sign in with email and password
// Sign in with email and password
  Future<UserCredential?> signInWithEmail(BuildContext context,String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (e) {
      if (kDebugMode) {
        print('Exception is here bro: $e, Type: ${e.runtimeType}');
      }

      if (e is FirebaseAuthException) {
        String errorMessage = '';
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'Invalid email address.';
            break;
          case 'user-not-found':
            errorMessage = 'User not found. Please sign up.';
            break;
          case 'wrong-password':
            errorMessage = 'Invalid password.';
            break;
        // Add more cases as per your requirements
          default:
            errorMessage = 'An error occurred. Please try again later.';
        }
        Navigator.pop(context);

        _showErrorDialog(context, errorMessage);
      } else {
        if (kDebugMode) {
          print('Error signing in and out: $e');
        }
        // Handle other types of exceptions or unknown errors
      }
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print("Error during password reset: ${e.message}");
    } catch (e) {
      print("Unexpected error during password reset: $e");
    }
  }

  //Save data to database

  void setData(String name, email,batch, rollNo, BuildContext context){
    String authId = FirebaseAuth.instance.currentUser!.uid;

    var id = DateTime.now().millisecondsSinceEpoch;
    final databaseRef = FirebaseFirestore.instance.collection('Users');
    databaseRef.doc(authId).set({
      'id': authId,
      'name': name,
      'email': email,
      'rollNo': rollNo,
      'batch': batch,


    }).then((value) {
      show(context, 'Sign up');
    }).onError((error, stackTrace) {
      show(context, error.toString());
    });
  }


  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print("Error during sign out: ${e.message}");
    } catch (e) {
      print("Unexpected error during sign out: $e");
    }
  }

  // Get the current user
  User? getCurrentUser() {
    try {
      return _auth.currentUser;
    } catch (e) {
      print("Unexpected error while getting current user: $e");
      return null;
    }
  }

  // Check if the user is signed in
  bool isUserSignedIn() {
    try {
      return _auth.currentUser != null;
    } catch (e) {
      print("Unexpected error while checking if user is signed in: $e");
      return false;
    }
  }

  ///google
  // final googleSignIn = GoogleSignIn();
  // GoogleSignInAccount? _user;
  // GoogleSignInAccount get user => _user!;
  // Future googleLogin(BuildContext context) async {
  //   final googleUser = await googleSignIn.signIn();
  //
  //   _user = googleUser;
  //
  //   final googleAuth = await googleUser!.authentication;
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //
  //
  //   if (appType == 'User') {
  //     print('in user if');
  //     if (userType != true) {
  //       print('in userType if');
  //
  //       if (userEmail == true) {
  //         print('in useremail if');
  //
  //         Utils.toastMessage(
  //             'Email already linked with another account, log In to your email and password');
  //         signOutGoogle();
  //       } else {
  //         print('in useremail else');
  //
  //         await FirebaseAuth.instance
  //             .signInWithCredential(credential)
  //             .then((value) async {
  //
  //           setData(user.email.toString(), user.displayName.toString(),
  //               'google','')
  //               .then((value) async {
  //
  //             Navigator.pushReplacement(context,
  //                 MaterialPageRoute(builder: (context)=>
  //                     SignUpWIthPhoneAndEmail(name: user.displayName.toString(), email: user.email.toString(),)));
  //
  //
  //           });
  //         });
  //       }
  //     } else {
  //       await FirebaseAuth.instance
  //           .signInWithCredential(credential)
  //           .then((value) async {
  //         String? userStatus= await getUserStatus(user.email.toString());
  //         bool? userDeleteStatus= await getUserDeleteStatus(user.email.toString());
  //
  //         String? isPhone =await getPhone();
  //         if(userDeleteStatus == false){
  //           if(userStatus == 'Activate' ) {
  //             if(isPhone == ''){
  //
  //               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInWithPhone()));
  //             }else{
  //               Utils.toastMessage('Signed In');
  //               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
  //             }
  //           }else{
  //             _showDialog(context, 'User is deactivated by admin, Kindly contact admin');
  //             signOut();
  //           }
  //         }else{
  //
  //           Utils.showDeletedDialog(context);
  //           signOut();
  //
  //
  //         }
  //
  //       });
  //     }
  //   } else {
  //     print('in user else');
  //     print(appTypeO);
  //
  //     if (appTypeO == 'Owner') {
  //       Utils.toastMessage('account linked with other app');
  //       signOutGoogle();
  //     } else {
  //       print(appTypeO);
  //       print('in user else else');
  //
  //       await FirebaseAuth.instance
  //           .signInWithCredential(credential)
  //           .then((value) async {
  //
  //         setData(
  //             user.email.toString(), user.displayName.toString(), 'google','sdfdfsd')
  //             .then((value) {
  //           Navigator.pushReplacement(
  //               context,
  //               MaterialPageRoute(builder: (context)=>
  //                   SignUpWIthPhoneAndEmail(name: user.displayName.toString(), email: user.email.toString(),)));
  //
  //         });
  //       });
  //     }
  //   }
  // }
}
