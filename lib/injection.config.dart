// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:indrive_flutter_client/src/data/DataSource/local/shared_preferences.dart'
    as _i23;
import 'package:indrive_flutter_client/src/data/DataSource/remote/services/auth_services.dart'
    as _i1070;
import 'package:indrive_flutter_client/src/di/app_module.dart' as _i752;
import 'package:indrive_flutter_client/src/domain/repository/auth_repository.dart'
    as _i706;
import 'package:indrive_flutter_client/src/domain/UseCases/auth/auth_use_cases.dart'
    as _i1047;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i23.SharedPref>(() => appModule.sharedPref);
    gh.factory<_i1070.AuthService>(() => appModule.authService);
    gh.factory<_i706.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i1047.AuthUseCases>(() => appModule.authUseCases);
    return this;
  }
}

class _$AppModule extends _i752.AppModule {}
