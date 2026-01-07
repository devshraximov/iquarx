part of 'home_map_cubit.dart';

class HomeMapState {
  final double latitude;
  final double longitude;
  final bool isInitial;
  final LocationAccessStatus access;
  final bool shouldMoveCamera;
  final String? lastLoggedLocation;
  final DateTime? lastLogTime;

  const HomeMapState({
    required this.latitude,
    required this.longitude,
    required this.isInitial,
    required this.access,
    this.shouldMoveCamera = false,
    this.lastLoggedLocation,
    this.lastLogTime,
  });

  factory HomeMapState.initial() => const HomeMapState(
    latitude: 0,
    longitude: 0,
    isInitial: true,
    access: LocationAccessStatus.denied,
    shouldMoveCamera: false,
  );

  HomeMapState copyWith({
    double? latitude,
    double? longitude,
    bool? isInitial,
    LocationAccessStatus? access,
    bool? shouldMoveCamera,
    String? lastLoggedLocation,
    DateTime? lastLogTime,
  }) {
    return HomeMapState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isInitial: isInitial ?? this.isInitial,
      access: access ?? this.access,
      shouldMoveCamera: shouldMoveCamera ?? this.shouldMoveCamera,
      lastLoggedLocation: lastLoggedLocation ?? this.lastLoggedLocation,
      lastLogTime: lastLogTime ?? this.lastLogTime,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeMapState &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.isInitial == isInitial &&
        other.access == access &&
        other.shouldMoveCamera == shouldMoveCamera &&
        other.lastLoggedLocation == lastLoggedLocation &&
        other.lastLogTime == lastLogTime;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^
        longitude.hashCode ^
        isInitial.hashCode ^
        access.hashCode ^
        shouldMoveCamera.hashCode ^
        lastLoggedLocation.hashCode ^
        lastLogTime.hashCode;
  }
}
