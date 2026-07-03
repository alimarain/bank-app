import 'package:get_it/get_it.dart';
import 'package:my_app/core/network/api_client.dart';
import 'package:my_app/data/repositories/auth_repository.dart';
import 'package:my_app/services/user_session_service.dart';
import 'package:stacked_services/stacked_services.dart';
import '../data/repositories/auth_repository_impl.dart';
import 'package:my_app/services/registration_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<SnackbarService>(() => SnackbarService());
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(locator<ApiClient>()),
  );
  locator.registerLazySingleton<RegistrationService>(
    () => RegistrationService(),
  );
  locator.registerLazySingleton<UserSessionService>(() => UserSessionService());
  locator.registerLazySingleton<ApiClient>(() => ApiClient());
}
