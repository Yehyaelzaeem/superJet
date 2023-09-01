import 'package:get_it/get_it.dart';
import 'package:superjet/super_jet_app/auth/data/data_sources/remote_datasource.dart';
import 'package:superjet/super_jet_app/auth/data/repositories/login_repo.dart';
import 'package:superjet/super_jet_app/auth/domain/repositories/base_auth_repo.dart';
import 'package:superjet/super_jet_app/auth/domain/use_cases/auth_usecase.dart';
import 'package:superjet/super_jet_app/auth/presentation/bloc/cubit.dart';
import '../../super_jet_app/app_layout/data/data_sources/data_source.dart';
import '../../super_jet_app/app_layout/data/repositories/trips_repo.dart';
import '../../super_jet_app/app_layout/domain/repositories/base_trips_repo.dart';
import '../../super_jet_app/app_layout/domain/use_cases/trips_usecase.dart';
import '../../super_jet_app/app_layout/presentation/bloc/cubit.dart';
import '../../super_jet_app/app_layout/presentation/bloc/trips_bloc.dart';

final sl = GetIt.instance;
class ServicesLocator{

  void init(){
    // Bloc
    sl.registerLazySingleton(() => TripsBloc(sl()));
    sl.registerLazySingleton(() => AuthCubit(sl()));
    sl.registerLazySingleton(() => SuperCubit(sl()));


    /// Use cases
     sl.registerLazySingleton(() => TripsUseCase(sl()));
     sl.registerLazySingleton(() => AuthUseCase(sl()));


    /// Repositories
    sl.registerLazySingleton<BaseTripsRepo>(() => TripsRepo(sl()));
    sl.registerLazySingleton<BaseAuthRepo>(() => AuthRepo(sl()));


    /// Data sources
     sl.registerLazySingleton<BaseSuperJetDataSource>(() => SuperJetDataSource());
     sl.registerLazySingleton<BaseAuthDataSource>(() => AuthDataSource());

  }
}

