import 'package:get_it/get_it.dart';
import 'package:iquarix/features/home/cubit/home/home_map_cubit.dart';
import 'package:iquarix/features/home/data/repository/home_repository.dart';
import 'package:iquarix/features/home/data/repository/home_repository_impl.dart';
import 'package:iquarix/iquarx_app.dart';
import 'package:iquarix/services/location/location_permission_service.dart';
import 'package:iquarix/services/location/location_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupRouter() async {
  final prefs = await SharedPreferences.getInstance();

  /// INITIALIZE SERVICES
  sl.registerLazySingleton<LocalSource>(() => LocalSourceImpl(prefs));
  sl.registerLazySingleton<AppRouter>(
    () => AppRouterImpl(routes: appRoutes, initialLocation: '/'),
  );
  sl.registerLazySingleton<DeviceInfoService>(() => DeviceInfoServiceImpl());
  sl.registerLazySingleton<DioConfig>(
    () => DioConfig(sl<LocalSource>(), isDebug: true),
  );
  sl.registerLazySingleton<ErrorMapper>(() => ErrorMapperImpl());
  sl.registerLazySingleton<Ticker>(() => const Ticker());
  sl.registerLazySingleton<LocationService>(() => LocationService());
  sl.registerLazySingleton<LocationPermissionService>(
    () => LocationPermissionService(),
  );

  /// REPOSITORIES
  sl.registerLazySingleton<PhoneAuthRepository>(
    () => PhoneAuthRepositoryImpl(
      sl<DioConfig>().dio,
      sl<DeviceInfoService>(),
      sl<ErrorMapper>(),
    ),
  );
  sl.registerLazySingleton<OtpRepository>(
    () => OtpRepositoryImpl(sl<DioConfig>().dio, sl<ErrorMapper>()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl<DioConfig>().dio, sl<ErrorMapper>()),
  );

  /// BLOC/CUBIT
  sl.registerFactory<SplashBloc>(() => SplashBloc(sl<LocalSource>()));
  sl.registerFactory<PhoneAuthCubit>(
    () => PhoneAuthCubit(sl<PhoneAuthRepository>()),
  );
  sl.registerFactory<TimerCubit>(() => TimerCubit(sl<Ticker>()));
  sl.registerFactory<OtpCubit>(() => OtpCubit(sl<OtpRepository>()));
  sl.registerFactory<HomeMapCubit>(
    () => HomeMapCubit(
      sl<LocationPermissionService>(),
      sl<LocationService>(),
      sl<HomeRepository>(),
    ),
  );
}
