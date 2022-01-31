import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:simple_calorie_app/models/user.dart' as model;

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  model.User? userModel;

  AuthController() {
    if (null == _auth.currentUser) {
      signInAnonymously();
    }
  }

  signInAnonymously() async {
    final userCredentials = await _auth.signInAnonymously();
    user = userCredentials.user;
    userModel =
        model.User(id: user!.uid, calLimit: 2100, since: DateTime.now());
  }

  Future<String> get userId async {
    if (null != user?.uid) {
      userModel =
          model.User(id: user!.uid, calLimit: 2100, since: DateTime.now());
      return user!.uid;
    } else {
      await signInAnonymously();
      return user!.uid;
    }
  }
}
