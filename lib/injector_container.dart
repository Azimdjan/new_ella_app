import 'package:dio/dio.dart';
import 'package:ella/core/platform/network_info.dart';
import 'package:ella/features/auth/data/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:ella/features/auth/data/repository/auth_repository_impl.dart';
import 'package:ella/features/auth/domain/usecases/sign_in.dart';
import 'package:ella/features/auth/domain/usecases/sign_up.dart';
import 'package:ella/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:ella/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features
  authFeature();
  //Core
  sl.registerLazySingleton(() => NetworkInfoImpl(sl()));
  //External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionCheckerPlus());
}

void authFeature() {
  ///Presentation
  sl.registerFactory(() => LoginBloc(signIn: sl()));
  sl.registerFactory(() => RegisterBloc(signUp: sl()));
  ///Usecases
  sl.registerLazySingleton<SignIn>(() => SignIn(sl()));
  sl.registerLazySingleton<SignUp>(() => SignUp(sl()));
  ///Repositories
  sl.registerLazySingleton<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: sl(),
      authLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  ///Data and Network
  sl.registerLazySingleton<AuthRemoteDataSourceImpl>(
    () => AuthRemoteDataSourceImpl(
      sl(),
    ),
  );
}
