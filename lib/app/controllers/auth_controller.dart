import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:haimed_getx/app/constant/environment_constant.dart';
import 'package:haimed_getx/app/mahas/mahas_config.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../mahas/services/helper.dart';
import '../mahas/services/http_api.dart';
import '../mahas/mahas_service.dart';
import '../routes/app_pages.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());
  late Rx<User?> firebaseUser;
  String? token;
  final box = GetStorage();
  RxBool firstOpenApp = false.obs;

  @override
  void onInit() async {
    late final FirebaseMessaging messaging = FirebaseMessaging.instance;
    token = await messaging.getToken();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
    super.onInit();
  }

  void _setInitialScreen(User? user) async {
    if (await box.read("new_install") != false) {
      firstOpenApp.value = true;
    }
    if (user == null) {
      if (firstOpenApp.value == true) {
        _toWelcomePage();
      } else {
        _toLigin();
      }
    } else {
      _toHome();
    }
  }

  void _toLigin() {
    Get.offAllNamed(Routes.LOGIN);
  }

  void _toWelcomePage() {
    Get.offAllNamed(Routes.WELCOME);
  }

  void _toHome() {
    MahasConfig.currentEnv == MahasEnvironmentType.premagana
        ? Get.offAllNamed(Routes.HOME_PREMAGANA)
        : Get.offAllNamed(Routes.home);
  }

  Future<UserCredential?> _signInWithCredentialGoogle() async {
    GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn(scopes: <String>["email"]).signIn();
    if (googleSignInAccount == null) return null;
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    return await auth.signInWithCredential(credential);
  }

  Future<void> singInWithPassword(String email, String pass) async {
    if (EasyLoading.isShow) return;
    await EasyLoading.show();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } on FirebaseAuthException catch (e) {
      Helper.errorToast(
        message: e.message,
      );
      await EasyLoading.dismiss();
    } catch (e) {
      Helper.errorToast(
        message: e.toString(),
      );
      await EasyLoading.dismiss();
    }
  }

  Future<void> signInWithGoogle() async {
    if (EasyLoading.isShow) return;
    await EasyLoading.show();
    try {
      var r = await _signInWithCredentialGoogle();
      box.write('apple_login', null);
      if (r == null) {
        await EasyLoading.dismiss();
      }
    } on FirebaseAuthException catch (e) {
      Helper.errorToast(
        message: e.message,
      );
      await EasyLoading.dismiss();
    } catch (e) {
      bool interneterror = MahasService.isInternetCausedError(e.toString());
      if (interneterror) {
        Helper.errorToast();
      } else {
        Helper.errorToast(message: e.toString());
      }
      await EasyLoading.dismiss();
    }
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential?> _signInWithCredentialApple() async {
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    return await auth.signInWithCredential(oauthCredential);
  }

  Future<void> signInWithApple() async {
    if (EasyLoading.isShow) return;
    await EasyLoading.show();
    try {
      await _signInWithCredentialApple();
      box.write('apple_login', true);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code != AuthorizationErrorCode.canceled) {
        Helper.errorToast(message: e.message);
      }
      await EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      Helper.errorToast(
        message: e.message,
      );
      await EasyLoading.dismiss();
    } catch (e) {
      await EasyLoading.dismiss();
      bool internetError = MahasService.isInternetCausedError(e.toString());
      if (internetError) {
        Helper.errorToast();
      } else {
        Helper.errorToast(message: e.toString());
      }
    }
  }

  Future signOut() async {
    if (EasyLoading.isShow) EasyLoading.dismiss();
    EasyLoading.show();
    token = null;
    await auth.signOut();
    await GoogleSignIn().signOut();
    EasyLoading.dismiss();
  }

  Future<void> deleteAccount() async {
    UserCredential? userCredential;
    try {
      if (box.read('apple_login') == true) {
        userCredential = await _signInWithCredentialApple();
      } else {
        userCredential = await _signInWithCredentialGoogle();
      }
      if (userCredential?.user != null) {
        var r = await HttpApi.delete('/api/auth');
        if (r.success) {
        } else {
          Get.defaultDialog(title: 'Error', middleText: r.message!);
        }
        await userCredential!.user!.delete();
      }
      auth.signOut();
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code != AuthorizationErrorCode.canceled) {
        Helper.errorToast(message: e.message);
      }
    } catch (e) {
      bool errorInternet = MahasService.isInternetCausedError(e.toString());
      if (errorInternet) {
        Helper.errorToast();
      } else {
        Helper.errorToast(message: e.toString());
      }
    }
  }
}
