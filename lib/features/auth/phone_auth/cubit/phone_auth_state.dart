part of 'phone_auth_cubit.dart';

class PhoneAuthState extends Equatable {
  const PhoneAuthState();

  @override
  List<Object?> get props => [];
}

class PhoneAuthInitial extends PhoneAuthState {
  @override
  List<Object> get props => [];
}

class PhoneAuthLoading extends PhoneAuthState {
  @override
  List<Object> get props => [];
}

class PhoneAuthSuccess extends PhoneAuthState {
  @override
  List<Object> get props => [];
}

class PhoneAuthError extends PhoneAuthState {
  final Failure failure;

  const PhoneAuthError({required this.failure});

  @override
  List<Object> get props => [];
}
