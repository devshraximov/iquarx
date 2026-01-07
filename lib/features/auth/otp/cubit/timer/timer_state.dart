part of 'timer_cubit.dart';

@freezed
class TimerState with _$TimerState {
  const factory TimerState.initial() = _Initial;

  const factory TimerState.timerProgress({required int duration}) =
      _TimerProgress;

  const factory TimerState.timerStop() = _TimerStop;

  const factory TimerState.timerCancel() = _TimerCancel;
}
