import 'package:iquarix/iquarx_app.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeMapCubit>()..startTracking(),
      child: const Scaffold(body: _HomePageContent()),
    );
  }
}

class _HomePageContent extends StatefulWidget {
  const _HomePageContent();

  @override
  State<_HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<_HomePageContent>
    with WidgetsBindingObserver {
  static const double _defaultZoom = 16.0;
  static const double _zoomStep = 1.0;
  static const double _cameraDuration = 1.0;
  static const Duration _snackBarDuration = Duration(seconds: 3);

  YandexMapController? _mapController;
  double _currentZoom = _defaultZoom;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    context.read<HomeMapCubit>().stopTracking();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      context.read<HomeMapCubit>().startTracking();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        _buildCameraAnimationListener(),
        _buildLocationUpdateListener(),
      ],
      child: Stack(
        children: [
          Column(children: [_buildPermissionBanner(), _buildMap()]),
          ProfileButton(onTap: _onProfileTap),
          MapControls(
            onZoomIn: _onZoomIn,
            onZoomOut: _onZoomOut,
            onCurrentLocation: _onCurrentLocationTap,
          ),
        ],
      ),
    );
  }

  BlocListener<HomeMapCubit, HomeMapState> _buildCameraAnimationListener() {
    return BlocListener<HomeMapCubit, HomeMapState>(
      listenWhen: (prev, curr) => curr.shouldMoveCamera,
      listener: (context, state) {
        if (!state.isInitial) {
          _animateCameraToLocation(state.latitude, state.longitude);
        }
      },
    );
  }

  BlocListener<HomeMapCubit, HomeMapState> _buildLocationUpdateListener() {
    return BlocListener<HomeMapCubit, HomeMapState>(
      listenWhen: (prev, curr) =>
          curr.lastLogTime != null && curr.lastLogTime != prev.lastLogTime,
      listener: (context, state) {
        if (state.lastLoggedLocation != null) {
          _showLocationSnackBar(state.lastLoggedLocation!);
        }
      },
    );
  }

  Widget _buildPermissionBanner() {
    return BlocBuilder<HomeMapCubit, HomeMapState>(
      buildWhen: (prev, curr) => prev.access != curr.access,
      builder: (context, state) => PermissionBanner(accessStatus: state.access),
    );
  }

  Widget _buildMap() {
    return Expanded(
      child: BlocBuilder<HomeMapCubit, HomeMapState>(
        buildWhen: (prev, curr) =>
            prev.latitude != curr.latitude ||
            prev.longitude != curr.longitude ||
            prev.isInitial != curr.isInitial,
        builder: (context, state) {
          return LocationMap(
            latitude: state.latitude,
            longitude: state.longitude,
            isInitial: state.isInitial,
            onMapCreated: (controller) {
              _mapController = controller;
              if (!state.isInitial) {
                _animateCameraToLocation(state.latitude, state.longitude);
              }
            },
          );
        },
      ),
    );
  }

  void _animateCameraToLocation(double latitude, double longitude) {
    _mapController?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(latitude: latitude, longitude: longitude),
          zoom: _defaultZoom,
        ),
      ),
      animation: const MapAnimation(
        type: MapAnimationType.smooth,
        duration: _cameraDuration,
      ),
    );
    context.read<HomeMapCubit>().cameraMovedToLocation();
  }

  void _showLocationSnackBar(String locationText) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(locationText),
        duration: _snackBarDuration,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _onProfileTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile page - coming soon'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onZoomIn() {
    _currentZoom += _zoomStep;
    _mapController?.moveCamera(
      CameraUpdate.zoomIn(),
      animation: const MapAnimation(
        type: MapAnimationType.smooth,
        duration: 0.3,
      ),
    );
  }

  void _onZoomOut() {
    _currentZoom -= _zoomStep;
    _mapController?.moveCamera(
      CameraUpdate.zoomOut(),
      animation: const MapAnimation(
        type: MapAnimationType.smooth,
        duration: 0.3,
      ),
    );
  }

  void _onCurrentLocationTap() {
    final state = context.read<HomeMapCubit>().state;
    if (!state.isInitial) {
      _animateCameraToLocation(state.latitude, state.longitude);
    }
  }
}
