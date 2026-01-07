import 'dart:async';
import 'package:iquarix/iquarx_app.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_cubit.freezed.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  final Ticker _ticker;
  static const int _duration = 60;

  StreamSubscription<int>? _tickerSubscription;

  TimerCubit(this._ticker) : super(const TimerState.initial());

  void onStartTimer() async {
    emit(const TimerState.timerProgress(duration: _duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: _duration).listen((duration) {
      _timerTicked(duration);
    });
  }

  void _timerTicked(int duration) {
    if (duration > 0) {
      emit(TimerState.timerProgress(duration: duration));
    } else {
      emit(const TimerState.timerStop());
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
