import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iquarix/iquarx_app.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final LocalSource _localSource;

  SplashBloc(this._localSource) : super(SplashInitial()) {
    on<SplashReadyEvent>(_onSplashReadyEvent);
  }

  Future<void> _onSplashReadyEvent(
    SplashReadyEvent event,
    Emitter<SplashState> emit,
  ) async {
    final token = _localSource.getAccessToken();
    await Future.delayed(const Duration(milliseconds: 1800));
    if (token.isNotEmpty) {
      emit(GoToHomeState());
    } else {
      emit(GoToAuthState());
    }
  }
}
