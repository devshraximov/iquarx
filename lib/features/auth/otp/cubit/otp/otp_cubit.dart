import 'package:iquarix/iquarx_app.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_state.dart';

part 'otp_cubit.freezed.dart';

class OtpCubit extends Cubit<OtpState> {
  final OtpRepository _repository;

  OtpCubit(this._repository) : super(const OtpState.initial());

  void confirmCodeButtonPres(DataMap request, String code) async {
    final result = await _repository.submitOtp(otp: code);

    result.fold(
      (failure) {
        emit(OtpState.showErrorMessage(failure));
      },
      (data) {
        emit(OtpState.success(request, data));
      },
    );
  }

  Future<void> resendCodeButtonPres(DataMap request) async {
    emit(const OtpState.resendLoading());

    // Simulate API call with 3 second delay
    await Future.delayed(const Duration(seconds: 3));

    // Reset to initial state and restart timer
    emit(const OtpState.initial());
    emit(const OtpState.restartTimer());

    // TODO: Uncomment and implement when API is ready
    // final result = await _repository.resendOtp();
    // result.fold(
    //   (failure) {
    //     emit(OtpState.showErrorMessage(failure));
    //   },
    //   (data) {
    //     emit(const OtpState.initial());
    //     emit(const OtpState.restartTimer());
    //   },
    // );
  }

  void otpCodeChanged(String value) {
    emit(const OtpState.invalidCode(false));
  }
}
