import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/core/language/cubits/locale_cubit.dart';
import 'package:to_do_app/core/language/data/data_sources/language_local_data_source.dart';
import 'package:to_do_app/core/language/domain/repositories/languge_repository.dart';
import 'package:to_do_app/core/language/domain/use_cases/cache_language_use_case.dart';
import 'package:to_do_app/core/language/domain/use_cases/get_cached_language_use_case.dart';
import 'package:to_do_app/core/network/network_info.dart';
import 'package:to_do_app/features/auth/data/data_sources/user_local_data_source.dart';
import 'package:to_do_app/features/auth/data/data_sources/user_remote_data_source.dart';
import 'package:to_do_app/features/auth/data/repositories_imp/user_repository_imp.dart';
import 'package:to_do_app/features/auth/domain/repositories/user_repository.dart';
import 'package:to_do_app/features/auth/domain/use_cases/Sign_in_use_case.dart';
import 'package:to_do_app/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:to_do_app/features/auth/presentation/blocs/auth/auth_blocs.dart';
import 'package:to_do_app/features/category/data/data_sources/category_local_data_source.dart';
import 'package:to_do_app/features/category/data/data_sources/category_remote_data_source.dart';
import 'package:to_do_app/features/category/data/repository_imp/category_repository_imp.dart';
import 'package:to_do_app/features/category/domain/use_cases/add_category_use_case.dart';
import 'package:to_do_app/features/category/domain/use_cases/get_all_categories_use_case.dart';
import 'package:to_do_app/features/category/presentation/blocs/CategoriesBloc/categories_blocs.dart';
import 'package:to_do_app/features/category/presentation/blocs/CategoryOperationsBloc/category_operations_blocs.dart';
import 'package:to_do_app/features/task/data/data_sources/task_local_data_source.dart';
import 'package:to_do_app/features/task/data/data_sources/task_remote_data_source.dart';
import 'package:to_do_app/features/task/data/repositories_imp/task_repository_imp.dart';
import 'package:to_do_app/features/task/domain/repositories/task_repository.dart';
import 'package:to_do_app/features/task/domain/use_cases/delete_task_use_case.dart';
import 'package:to_do_app/features/task/domain/use_cases/get_today_tasks_use_case.dart';
import 'package:to_do_app/features/task/domain/use_cases/show_productivity_use_case.dart';
import 'package:to_do_app/features/task/domain/use_cases/update_task._use_case.dart';
import 'package:to_do_app/features/task/presentation/blocs/Tasks_bloc/tasks_bloc.dart';
import 'package:to_do_app/features/task/presentation/blocs/task_operations_bloc/task_operations_bloc.dart';
import '../../features/auth/domain/use_cases/logout_use_case.dart';
import '../language/data/repository_imp/language_repository_imp.dart';
import '../../features/auth/domain/use_cases/is_logged_in_use_case.dart';
import '../../features/auth/presentation/blocs/is_logged_in_bloc/is_logged_in_bloc.dart';
import '../../features/category/domain/repositories/category_repository.dart';
import '../../features/category/domain/use_cases/delete_category_use_case.dart';
import '../../features/category/domain/use_cases/update_category_use_case.dart';
import '../../features/task/domain/use_cases/add_task_use_case.dart';
import '../../features/task/domain/use_cases/do_task_use_case.dart';
import '../../features/task/domain/use_cases/get_all_tasks_use_case.dart';
import '../../features/task/presentation/blocs/productivity_bloc/productivity_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  //features: auth /////////////////////////////////////////////////////////////

  //Bloc
  sl.registerFactory(() => AuthBloc(signIn: sl(), signUp: sl() , logout: sl()));
  sl.registerFactory(() => IsLoggedInBloc(isLoggedIn: sl()));

  //use case
  sl.registerLazySingleton(() => SignInUseCase(repository: sl()));
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl()));
  sl.registerLazySingleton(() => IsLoggedInUseCase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));

  //repository
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImp(remoteDataSource: sl(), localDataSource: sl() , networkInfo: sl()));

  //data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImp());
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImp(sharedPreferences: sl()));



  //feature: category //////////////////////////////////////////////////////////

  //Bloc
  sl.registerFactory(() => CategoryOperationsBloc(
      addCategory: sl(), deleteCategory: sl(), updateCategory: sl()));
  sl.registerLazySingleton(() => CategoriesBloc(getAllCategories: sl()));

  //use cases
  sl.registerLazySingleton(() => AddCategoryUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteCategoryUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateCategoryUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllCategoriesUseCase(repository: sl()));

  //repository
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImp(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  //data sources
  sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImp());
  sl.registerLazySingleton<CategoryLocalDataSource>(
      () => CategoryLocalDataSourceImp(sharedPreferences: sl()));


  //feature: task //////////////////////////////////////////////////////////////

  //Bloc
  sl.registerFactory(() => TasksBloc(getAllTasks: sl(), getTodayTasks: sl()));
  sl.registerFactory(() => TaskOperationsBloc(
      addTask: sl(), deleteTask: sl(), updateTask: sl(), doTask: sl()));
  sl.registerFactory(() => ProductivityBloc(showProductivity: sl()));

  //use cases
  sl.registerLazySingleton(() => GetAllTasksUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetTodayTasksUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddTaskUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateTaskUseCase(repository: sl()));
  sl.registerLazySingleton(() => DoTaskUseCase(repository: sl()));
  sl.registerLazySingleton(() => ShowProductivityUseCase(repository: sl()));

  //repository
  sl.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImp(remoteDataSource: sl(), localDataSource: sl() , networkInfo: sl()));

  //data sources
  sl.registerLazySingleton<TaskRemoteDataSource>(
      () => TaskRemoteDataSourceImp());
  sl.registerLazySingleton<TaskLocalDataSource>(
      () => TaskLocalDataSourceImp(sharedPreferences: sl()));

  //feature: language //////////////////////////////////////////////////////////////

  //Cubit
  sl.registerFactory(
      () => LocaleCubit(cacheLanguage: sl(), getCachedLanguage: sl()));

  //use case
  sl.registerLazySingleton(() => CacheLanguageUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCachedLanguageUseCase(repository: sl()));

  //repository
  sl.registerLazySingleton<LanguageRepository>(
      () => LanguageRepositoryImp(localDataSource: sl()));

  //data sources
  sl.registerLazySingleton<LanguageLocalDataSource>(
      () => LanguageLocalDataSourceImp(sharedPreferences: sl()));


  //core////////////////////////////////////////////////////////////////////////
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));

  //external////////////////////////////////////////////////////////////////////
  sl.registerLazySingleton(() => InternetConnectionChecker());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
