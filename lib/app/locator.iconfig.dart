// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:tinkler/theme/app_theme_service.dart';
import 'package:tinkler/services/functional_services/authentication_service.dart';
import 'package:tinkler/services/state_services/current_chatroom_service.dart';
import 'package:tinkler/services/state_services/current_user_service.dart';
import 'package:tinkler/services/functional_services/database_service.dart';
import 'package:tinkler/services/functional_services/third_party_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/services/functional_services/firebase_service.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<AppThemeService>(() => AppThemeService());
  g.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
  g.registerLazySingleton<CurrentChatroomService>(
      () => CurrentChatroomService());
  g.registerLazySingleton<CurrentUserService>(() => CurrentUserService());
  g.registerLazySingleton<DatabaseService>(() => DatabaseService());
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<FirebaseService>(() => FirebaseService());
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
}
