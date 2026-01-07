import 'package:flutter/material.dart';
import 'package:iquarix/core/helper/enums.dart';
import 'package:iquarix/features/home/cubit/home/home_map_cubit.dart';
import 'package:iquarix/iquarx_app.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeMapCubit>()..startTracking(),
      child: const Scaffold(body: _HomePageForm()),
    );
  }
}

class _HomePageForm extends StatefulWidget {
  const _HomePageForm();

  @override
  State<_HomePageForm> createState() => _HomePageFormState();
}

class _HomePageFormState extends State<_HomePageForm> {
  YandexMapController? _mapController;

  @override
  void dispose() {
    context.read<HomeMapCubit>().stopTracking();
    super.dispose();
  }

  void _moveToCurrentLocation(double lat, double lng) {
    _mapController?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(latitude: lat, longitude: lng),
          zoom: 16,
        ),
      ),
      animation: const MapAnimation(type: MapAnimationType.smooth, duration: 1),
    );
    context.read<HomeMapCubit>().cameraMovedToLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Camera harakatlantirish uchun listener
        BlocListener<HomeMapCubit, HomeMapState>(
          listenWhen: (prev, curr) => curr.shouldMoveCamera,
          listener: (context, state) {
            if (!state.isInitial) {
              _moveToCurrentLocation(state.latitude, state.longitude);
            }
          },
        ),
        // Har 15 soniyada location log qilish uchun
        BlocListener<HomeMapCubit, HomeMapState>(
          listenWhen: (prev, curr) =>
              curr.lastLogTime != null && curr.lastLogTime != prev.lastLogTime,
          listener: (context, state) {
            if (state.lastLoggedLocation != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Current Location: ${state.lastLoggedLocation}',
                  ),
                  duration: const Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        ),
      ],
      child: Column(
        children: [
          // Permission xatolari uchun persistent banner
          BlocBuilder<HomeMapCubit, HomeMapState>(
            buildWhen: (prev, curr) => prev.access != curr.access,
            builder: (context, state) {
              return _PermissionBanner(accessStatus: state.access);
            },
          ),
          // Xarita
          Expanded(
            child: BlocBuilder<HomeMapCubit, HomeMapState>(
              buildWhen: (prev, curr) =>
                  prev.latitude != curr.latitude ||
                  prev.longitude != curr.longitude ||
                  prev.isInitial != curr.isInitial,
              builder: (context, state) {
                return YandexMap(
                  onMapCreated: (controller) {
                    _mapController = controller;
                    // Agar location allaqachon mavjud bo'lsa, darhol harakat
                    if (!state.isInitial) {
                      _moveToCurrentLocation(state.latitude, state.longitude);
                    }
                  },
                  mapObjects: [
                    if (!state.isInitial) ...[
                      // Asosiy nuqta (blue dot)
                      CircleMapObject(
                        mapId: const MapObjectId('current_location_dot'),
                        circle: Circle(
                          center: Point(
                            latitude: state.latitude,
                            longitude: state.longitude,
                          ),
                          radius: 8, // 8 metr radius
                        ),
                        strokeColor: Colors.white,
                        strokeWidth: 2,
                        fillColor: const Color(0xFF4285F4), // Google Maps blue
                      ),
                      // Atrofdagi aylana (accuracy circle)
                      CircleMapObject(
                        mapId: const MapObjectId('current_location_accuracy'),
                        circle: Circle(
                          center: Point(
                            latitude: state.latitude,
                            longitude: state.longitude,
                          ),
                          radius: 30, // accuracy radiusi
                        ),
                        strokeColor: const Color(0x404285F4),
                        strokeWidth: 1,
                        fillColor: const Color(0x204285F4),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Alohida widget performance uchun
class _PermissionBanner extends StatelessWidget {
  final LocationAccessStatus accessStatus;

  const _PermissionBanner({required this.accessStatus});

  @override
  Widget build(BuildContext context) {
    if (accessStatus == LocationAccessStatus.granted) {
      return const SizedBox.shrink();
    }

    final (message, color, action) = _getBannerContent(context);

    return MaterialBanner(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
      leading: const Icon(Icons.warning_amber_rounded, color: Colors.white),
      actions: [
        if (action != null)
          TextButton(
            onPressed: action,
            child: const Text(
              'Sozlamalar',
              style: TextStyle(color: Colors.white),
            ),
          )
        else
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: const Text('OK', style: TextStyle(color: Colors.white)),
          ),
      ],
    );
  }

  (String, Color, VoidCallback?) _getBannerContent(BuildContext context) {
    switch (accessStatus) {
      case LocationAccessStatus.serviceDisabled:
        return ("GPS o'chiq. Location service'ni yoqing.", Colors.orange, null);
      case LocationAccessStatus.denied:
        return ('Location ruxsati berilmadi.', Colors.red.shade700, null);
      case LocationAccessStatus.deniedForever:
        return (
          'Location ruxsati butunlay bloklangan.',
          Colors.red.shade900,
          () {
            // sl<LocationPermissionService>().openAppSettings();
            // yoki cubit orqali
          },
        );
      case LocationAccessStatus.granted:
        return ('', Colors.transparent, null);
    }
  }
}
