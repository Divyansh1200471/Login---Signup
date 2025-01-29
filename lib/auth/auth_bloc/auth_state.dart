part of 'auth_cubit.dart';

abstract class AuthState {

  const AuthState();
}

/// Initial State
class AuthInitial extends AuthState {}

/// Loading State

class AuthLoading extends AuthState {}

/// Valid User

class Verified extends AuthState {
  final AppUser user;
  Verified(this.user);
}

/// UnValid User

class Unverified extends AuthState {

}


/// Any Errors

class ErrorState extends AuthState {
  final String error;

  ErrorState(this.error);
}



