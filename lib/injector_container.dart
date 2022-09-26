import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ella/core/platform/network_info.dart';
import 'package:ella/features/auth/data/data_source/local/auth_local_data_source_impl.dart';
import 'package:ella/features/auth/data/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:ella/features/auth/data/repository/auth_repository_impl.dart';
import 'package:ella/features/auth/domain/usecases/sign_in.dart';
import 'package:ella/features/auth/domain/usecases/sign_up.dart';
import 'package:ella/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:ella/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'features/auth/data/data_source/local/auth_local_data_source.dart';
import 'features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'features/auth/domain/repository/auth_repository.dart';

final sl = GetIt.instance;
late Box<dynamic> _box;

Future<void> init() async {
  //External
  await initHive();
  sl.registerLazySingleton(
    () => Dio()
      ..interceptors.add(
        LogInterceptor(
          request: true,
          responseBody: true,
          error: true,
          requestBody: true,
        ),
      ),
  );
  sl.registerLazySingleton(() => InternetConnectionCheckerPlus());
  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // Features
  authFeature();
}

void authFeature() {
  ///Presentation
  sl.registerFactory(() => LoginBloc(signIn: sl()));
  sl.registerFactory(() => RegisterBloc(signUp: sl()));

  ///Usecases
  sl.registerLazySingleton<SignIn>(() => SignIn(sl()));
  sl.registerLazySingleton<SignUp>(() => SignUp(sl()));

  ///Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: sl(),
      authLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  ///Data and Network
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      sl(),
    ),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      _box,
    ),
  );
}

Future<void> initHive() async {
  const boxName = 'ella_box';
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  _box = await Hive.openBox<dynamic>(boxName);
}
