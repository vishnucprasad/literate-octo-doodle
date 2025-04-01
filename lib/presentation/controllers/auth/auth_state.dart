import 'package:aaraadhya_temple_dashboard/core/exceptions/auth_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(true) bool isAuthenticating,
    @Default(false) bool isSigningOut,
    @Default(null) User? user,
    @Default(null) AuthException? error,
  }) = _AuthState;
}
