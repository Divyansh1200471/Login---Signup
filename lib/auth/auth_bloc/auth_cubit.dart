import 'package:bloc/bloc.dart';

import 'package:hive/hive.dart';

import '../../model/user_model.dart';
import '../auth_repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial()) {
    checkAuth();
  }

  /// Check If user is already Authenticate

  void checkAuth() async {
    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      currentUser = user;
      emit(Verified(user));
    } else {
      emit(Unverified());
    }
  }

  /// get Current user

  AppUser? get _currentUser => currentUser;

  /// Login with email and password

  Future<void> login(String email, String pw) async {
    var box = await Hive.openBox('authBox');

    try {
      emit(AuthLoading());
      final user = await authRepo.loginWithEmailAndPassword(email, pw);

      if (user != null) {
        currentUser = user;
        box.put('isLoggedIn', true);

        emit(Verified(user));
      } else {
        emit(Unverified());
      }
    } catch (e) {
      emit(Unverified());
      emit(ErrorState(e.toString()));
    }
  }

  /// SignUp with email and Password

  Future<void> signup(
    String name,
    String email,
    String pw,
  ) async {
    var box = await Hive.openBox('authBox');

    try {
      emit(AuthLoading());
      final user = await authRepo.signUpWithEmailAndPassword(email: email, password: pw, name: name);

      if (user != null) {
        currentUser = user;
        emit(Verified(user));
      } else {
        box.put('isLoggedIn', false);
        emit(Unverified());
      }
    } catch (e) {
      emit(Unverified());
      emit(ErrorState(e.toString()));
    }
  }

   /// logout

  Future<void> logout() async {
    authRepo.logOut();
    emit(Unverified());
  }


  Future<void> signInWithGoogleProcess() async {
    try {
      emit(AuthLoading());  // Show loading state

      // Call the repo method to sign in with Google
      final AppUser? user = await authRepo.signInWithGoogle();

      // Check if user is successfully authenticated
      if (user != null) {
        currentUser = user;
        emit(Verified(user));  // Emit the Verified state if user exists
      } else {
        emit(Unverified());  // Emit Unverified if no user returned
      }
    } catch (e) {

      emit(Unverified());  // Emit Unverified if there is an error
      emit(ErrorState(e.toString()));  // Emit the error message
    }
  }

}
