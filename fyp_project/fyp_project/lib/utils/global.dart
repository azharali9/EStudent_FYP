import 'package:flutter/material.dart';

import 'colors.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // dialog cannot be dismissed by tapping outside
    builder: (BuildContext context) {
      return    Center(child: CircularProgressIndicator(
        color: primaryColor,
      ));
    },
  );

  // Simulate some async operation
}

// Future<String?> getUserType(String email) async {
//   DataSnapshot dataSnapshot = await FirebaseDatabase.instance
//       .ref()
//       .child('Users')
//       .orderByChild('email')
//       // .equalTo(email)
//       .get();
//
//   if (dataSnapshot.value != null) {
//     // Assuming 'userLoginType' is a key in your database structure
//     String content = dataSnapshot.child('content').value.toString();
//     // dynamic userLoginType = dataSnapshot.value.values.first['userLoginType'];
//     print(content);
//     return content;
//   } else {
//     return null;
//   }
// }