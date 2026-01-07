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
        emit(const OtpState.showErrorMessage("Invalid code"));
      },
      (data) {
        emit(OtpState.success(request, data));
      },
    );
  }

  void resendCodeButtonPres(DataMap request) async {
    // final newRequest = request..code = null;
    //
    // emit(const OtpState.showLoading());
    // final result = await _loginPhoneNumUsecase(params: newRequest);
    // emit(const OtpState.dismissLoading());
    // result.fold(
    //       (failure) {
    //     emit(OtpState.showErrorMessage(failure.message));
    //   },
    //       (data) {
    //     emit(const OtpState.restartTimer());
    //     emit(OtpState.updateInitialArgs(request.copyWith(code: data['code'])));
    //   },
    // );
  }

  void otpCodeChanged(String value) {
    emit(const OtpState.invalidCode(false));
  }
}
