import 'dart:async';
import 'dart:developer' as dev;

import 'package:geolocator/geolocator.dart';
import 'package:iquarix/core/helper/enums.dart';
import 'package:iquarix/iquarx_app.dart';
import 'package:iquarix/services/location/location_permission_service.dart';
import 'package:iquarix/services/location/location_service.dart';

part 'home_map_state.dart';

/// Business logic for home map screen with real-time location tracking
class HomeMapCubit extends Cubit<HomeMapState> {
  HomeMapCubit(
    this._permissionService,
    this._locationService,
  ) : super(HomeMapState.initial());

  static const Duration _locationUpdateInterval = Duration(seconds: 15);
  static const String _logName = 'HomeMapCubit';

  final LocationPermissionService _permissionService;
  final LocationService _locationService;

  StreamSubscription<Position>? _positionSubscription;
  Timer? _periodicTimer;

  /// Initializes location tracking with permission check
  Future<void> startTracking() async {
    final accessStatus = await _permissionService.ensurePermission();
    emit(state.copyWith(access: accessStatus));

    if (accessStatus != LocationAccessStatus.granted) {
      dev.log(
        'Location permission not granted: $accessStatus',
        name: _logName,
      );
      return;
    }

    await _initializeLocationStream();
    _startPeriodicLocationLogging();
  }

  /// Sets up continuous location updates stream
  Future<void> _initializeLocationStream() async {
    await _positionSubscription?.cancel();

    _positionSubscription = _locationService.getPositionStream().listen(
      _onLocationUpdate,
      onError: (error, stackTrace) {
        dev.log(
          'Location stream error',
          name: _logName,
          error: error,
          stackTrace: stackTrace,
        );
      },
    );
  }

  /// Handles incoming location updates from stream
  void _onLocationUpdate(Position position) {
    emit(
      state.copyWith(
        latitude: position.latitude,
        longitude: position.longitude,
        isInitial: false,
        access: LocationAccessStatus.granted,
        shouldMoveCamera: state.isInitial,
      ),
    );
  }

  /// Starts periodic location logging timer
  void _startPeriodicLocationLogging() {
    _periodicTimer?.cancel();
    _periodicTimer = Timer.periodic(
      _locationUpdateInterval,
      (_) => _logCurrentLocation(),
    );
  }

  /// Logs current location coordinates periodically
  void _logCurrentLocation() {
    if (state.isInitial) return;

    final timestamp = DateTime.now();
    final locationString = _formatLocationString(
      state.latitude,
      state.longitude,
    );

    dev.log(
      'Location update: $locationString',
      name: _logName,
    );

    // TODO: Uncomment when backend is ready
    // await _repository.sendLocation(state.latitude, state.longitude);

    emit(
      state.copyWith(
        lastLoggedLocation: locationString,
        lastLogTime: timestamp,
      ),
    );
  }

  /// Formats location coordinates for display
  String _formatLocationString(double lat, double lng) {
    return 'Lat: ${lat.toStringAsFixed(6)}, Lng: ${lng.toStringAsFixed(6)}';
  }

  /// Resets camera movement flag after animation completes
  void cameraMovedToLocation() {
    if (state.shouldMoveCamera) {
      emit(state.copyWith(shouldMoveCamera: false));
    }
  }

  /// Opens app settings for location permission
  Future<void> openAppSettings() async {
    await _permissionService.openAppSettings();
  }

  /// Stops all location tracking and cleans up resources
  void stopTracking() {
    _positionSubscription?.cancel();
    _positionSubscription = null;

    _periodicTimer?.cancel();
    _periodicTimer = null;

    dev.log('Location tracking stopped', name: _logName);
  }

  @override
  Future<void> close() {
    stopTracking();
    return super.close();
  }
}
