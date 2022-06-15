import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_app/src/features/posts_feature/data_layer/data_source/local_data_source.dart';
import 'package:tdd_app/src/features/posts_feature/data_layer/data_source/remote_data_source.dart';
import 'package:tdd_app/src/features/posts_feature/domain_layer/use_cases/create_post_use_case.dart';
import 'package:tdd_app/src/features/posts_feature/domain_layer/use_cases/delete_post_use_case.dart';
import 'package:tdd_app/src/features/posts_feature/domain_layer/use_cases/get_posts_use_case.dart';
import 'package:tdd_app/src/features/posts_feature/domain_layer/use_cases/update_post_use_case.dart';
import 'package:tdd_app/src/features/posts_feature/presentation_layer/bloc/post_bloc/post_bloc.dart';
import 'package:tdd_app/src/features/posts_feature/presentation_layer/bloc/posts_bloc/posts_bloc.dart';
import 'src/core/errors/failures_handling.dart';
import 'src/core/network/network_info.dart';
import 'src/features/posts_feature/data_layer/repositories/post_repository_impl.dart';
import 'src/features/posts_feature/domain_layer/repositories/post_repository.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  ///POSTS FEATURE

  //Blocs
  sl.registerFactory(
    () => PostsBloc(getAllPosts: sl(), failuresHandling: sl()),
  );
  sl.registerFactory(
    () => PostBloc(
      createPost: sl(),
      updatePost: sl(),
      deletePost: sl(),
      failuresHandling: sl(),
    ),
  );
  //UseCases
  sl.registerLazySingleton(
    () => GetAllPostsUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => CreatePostUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => UpdatePostUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => DeletePostUseCase(sl()),
  );
  //Repository
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  //Data Sources
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImplWithHttp(client: sl()),
  );
  sl.registerLazySingleton<PostLocalDataSource>(
    () => PostLocalDataSourceImplWithSharedPreferences(preferences: sl()),
  );

  ///POSTS FEATURE

  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImplWithConnectionChecker(connectionChecker: sl()),
  );
  sl.registerLazySingleton(() => FailuresHandling());
  //External Plugins
  SharedPreferences preferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => preferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
}
