library;

/// SYSTEM PATH
export 'package:adaptive_theme/adaptive_theme.dart';
export 'package:flutter/material.dart';
export 'package:keyboard_dismisser/keyboard_dismisser.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

/// CORE PATH
export 'core/constants/app_theme.dart';
export 'core/observers/app_bloc_observer.dart';
export 'core/observers/app_navigator_observer.dart';
export 'core/constants/api_constants.dart';
export 'core/constants/locale_keys.dart';
export 'core/error/exceptions.dart';
export 'core/error/failure.dart';
export 'core/helper/either.dart';
export 'core/helper/typedefs.dart';
export 'core/helper/ticker.dart';
export 'core/common/widgets/button/clear_button.dart';
export 'core/common/widgets/app_bar/custom_app_bar.dart';

/// SERVICES PATH
export 'services/route_management/app_router/app_router.dart';
export 'services/route_management/app_router/app_router_impl.dart';
export 'services/route_management/app_routes.dart';
export 'services/route_management/router_keys.dart';
export 'services/dependency_injection/injection_container.dart';
export 'services/device_info/device_info_service.dart';
export 'services/local_source/local_source.dart';
export 'services/local_source/local_source_impl.dart';
export 'services/interceptors/token_interceptor.dart';
export 'services/dio/dio_config.dart';
export 'services/error_mapper/error_mapper.dart';
export 'services/error_mapper/error_mapper_impl.dart';
export 'services/app_assistants/app_assistants.dart';

/// FEATURES PATH
export 'features/splash/splash_page.dart';
export 'features/splash/bloc/splash_bloc.dart';
export 'features/auth/phone_auth/phone_auth_page.dart';
export 'features/auth/phone_auth/data/repository/phone_auth_repository.dart';
export 'features/auth/phone_auth/data/repository/phone_auth_repository_impl.dart';
export 'features/auth/phone_auth/data/models/phone_auth_request.dart';
export 'features/auth/phone_auth/cubit/phone_auth_cubit.dart';
export 'features/auth/otp/cubit/otp/otp_cubit.dart';
export 'features/auth/otp/cubit/timer/timer_cubit.dart';
export 'features/auth/otp/data/repository/otp_repository.dart';
export 'features/auth/otp/data/repository/otp_repository_impl.dart';
export 'features/auth/otp/otp_page.dart';
export 'features/home/home_page.dart';
