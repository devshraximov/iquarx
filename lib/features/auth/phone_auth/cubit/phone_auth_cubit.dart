import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iquarix/iquarx_app.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final PhoneAuthRepository _repository;

  PhoneAuthCubit(this._repository) : super(PhoneAuthInitial());

  void completeShowError() {
    emit(PhoneAuthInitial());
  }

  Future<void> submitPhone(String phone) async {
    emit(PhoneAuthLoading());
    await Future.delayed(const Duration(seconds: 2));
    final result = await _repository.submitPhone(phone: phone);
    result.fold((failure) => emit(PhoneAuthError(failure: failure)), (data) {
      emit(PhoneAuthSuccess());
    });
  }
}
