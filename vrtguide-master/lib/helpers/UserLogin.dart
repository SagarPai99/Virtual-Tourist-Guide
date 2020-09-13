import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:vrtguide/helpers/ApiConnect.dart';

class UserLogin {
  GoogleSignInAccount _currentUser;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  UserLogin() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      _currentUser = account;
    });
    _googleSignIn.signInSilently();
  }

  Future<Map> signIn() async {
    try {
      if (!(await _googleSignIn.isSignedIn()))
        await _googleSignIn.signInSilently();
      if (!(await _googleSignIn.isSignedIn())) await _googleSignIn.signIn();
      if (_currentUser != null) {
        Map data = await ApiConnect.findOrRegisterUser({
          "gid": _currentUser.id,
          "name": _currentUser.displayName,
          "email": _currentUser.email,
          "photoUrl": _currentUser.photoUrl
        });
        return data;
      } else
        return {"success": false};
    } catch (e) {
      print(e);
      return {"success": false};
    }
  }
}
