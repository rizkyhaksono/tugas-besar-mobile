import 'package:get/get.dart';
import 'package:push_puzzle/constants/auth_service.dart';

class SignInController extends GetxController {
  final AuthService _authService = AuthService();
  final RxBool isLoading = false.obs;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    isLoading.value = true;
    var user = await _authService.signInWithEmailAndPassword(email, password);
    isLoading.value = false;
    if (user != null) {
      // Navigate to the next screen or perform other actions
    } else {
      // Show error message or handle the error
    }
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    var user = await _authService.signInWithGoogle();
    isLoading.value = false;
    if (user != null) {
      // Navigate to the next screen or perform other actions
    } else {
      // Show error message or handle the error
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    // Additional sign-out logic if needed
  }
}
