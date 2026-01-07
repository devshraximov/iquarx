import 'dart:async';
import 'dart:developer' as dev;

import 'package:iquarix/core/helper/enums.dart';
import 'package:iquarix/features/home/data/repository/home_repository.dart';
import 'package:iquarix/iquarx_app.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iquarix/services/location/location_permission_service.dart';
import 'package:iquarix/services/location/location_service.dart';

part 'home_map_state.dart';

class HomeMapCubit extends Cubit<HomeMapState> {
  HomeMapCubit(this._permissionService, this._locationService, this._repository)
    : super(HomeMapState.initial());

  final LocationPermissionService _permissionService;
  final LocationService _locationService;
  final HomeRepository _repository;

  StreamSubscription<Position>? _positionSubscription;
  Timer? _periodicLogger;
  DateTime? _lastLogTime;

  Future<void> startTracking() async {
    final access = await _permissionService.ensurePermission();
    emit(state.copyWith(access: access));

    if (access != LocationAccessStatus.granted) return;

    _positionSubscription?.cancel();
    _positionSubscription = _locationService.getPositionStream().listen(
      _handlePositionUpdate,
      onError: (error) {
        dev.log('Location stream error: $error', name: 'HomeMapCubit');
      },
    );

    _startPeriodicLogging();
  }

  void _handlePositionUpdate(Position pos) {
    emit(
      state.copyWith(
        latitude: pos.latitude,
        longitude: pos.longitude,
        isInitial: false,
        access: LocationAccessStatus.granted,
        shouldMoveCamera: state.isInitial,
      ),
    );
  }

  void _startPeriodicLogging() {
    _periodicLogger?.cancel();
    _periodicLogger = Timer.periodic(
      const Duration(seconds: 15),
      (_) => _logCurrentLocation(),
    );
  }

  void _logCurrentLocation() {
    if (state.isInitial) return;

    final now = DateTime.now();
    _lastLogTime = now;
    _repository.sendLocation(state.latitude, state.longitude);
    emit(
      state.copyWith(
        lastLoggedLocation: '${state.latitude}, ${state.longitude}',
        lastLogTime: now,
      ),
    );
  }

  void cameraMovedToLocation() {
    if (state.shouldMoveCamera) {
      emit(state.copyWith(shouldMoveCamera: false));
    }
  }

  void stopTracking() {
    _positionSubscription?.cancel();
    _periodicLogger?.cancel();
  }

  @override
  Future<void> close() {
    stopTracking();
    return super.close();
  }
}
