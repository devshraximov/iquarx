part of 'otp_cubit.dart';

@freezed
class OtpState with _$OtpState {
  const factory OtpState.initial() = _Initial;

  const factory OtpState.showLoading() = _ShowLoading;

  const factory OtpState.dismissLoading() = _DismissLoading;

  const factory OtpState.restartTimer() = _RestartTimer;

  const factory OtpState.stopTimer() = _StopTimer;

  const factory OtpState.invalidCode(bool value) = _InvalidCode;

  const factory OtpState.showErrorMessage(String message) = _ShowErrorMessage;

  const factory OtpState.updateInitialArgs(DataMap args) = _UpdateInitialArgs;

  const factory OtpState.success(DataMap request, DataMap data) = _Success;
}
