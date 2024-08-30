import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/category/presentation/screens/add_category_screen.dart';
import '../../features/category/presentation/screens/show_categories_screen.dart';
import '../../features/task/presentation/screens/add_task_screen.dart';
import '../../features/task/presentation/screens/productivity_screen.dart';
import '../../features/task/presentation/screens/show_tasks_screen.dart';
import '../../features/task/presentation/screens/show_today_tasks_screen.dart';
import '../screens/scaffold_with_navBar_screen.dart';
import '../strings/route_names.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter router = GoRouter(
    // redirect: (context , state) => redirect(),
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
          name: RouteNames.signIn,
          path: '/',
          builder: (context, state) {
            return const SignInScreen();
          },
          routes: [
            GoRoute(
              name: RouteNames.signUp,
              path: 'sign_up',
              builder: (context, state) {
                return const SignUpScreen();
              },
            ),
            StatefulShellRoute.indexedStack(
                builder: (context, state, navigationShell) =>
                    ScaffoldWithNavBar(navigationShell: navigationShell),
                branches: [
                  StatefulShellBranch(routes: <RouteBase>[
                    GoRoute(
                        //parentNavigatorKey: _rootNavigatorKey,
                        name: RouteNames.showCategories,
                        path: 'show_categories',
                        builder: (context, state) {
                          return const ShowCategoriesScreen();
                        },
                        routes: [
                          GoRoute(
                            name: RouteNames.showTasks,
                            path: 'show_tasks/:categoryID',
                            builder: (context, state) {
                              return ShowTasksScreen(
                                  categoryId:
                                      state.pathParameters['categoryID']!);
                            },
                          ),
                          GoRoute(
                              name: RouteNames.addCategory,
                              path: 'add_category',
                              builder: (context, state) {
                                return const AddCategoryScreen();
                              }),
                          GoRoute(
                              name: RouteNames.addTask,
                              path: 'add_task/:categoryID',
                              builder: (context, state) {
                                return AddTaskScreen(
                                    categoryId: state.pathParameters['categoryID']!);
                              }),
                        ]),
                  ]),
                  StatefulShellBranch(routes: <RouteBase>[
                    GoRoute(
                      name: RouteNames.showTodayTasks,
                      path: 'show_today_tasks',
                      builder: (context, state) {
                        return const ShowTodayTasksScreen();
                      },
                    ),
                  ]),
                  StatefulShellBranch(routes: <RouteBase>[
                    GoRoute(
                      //parentNavigatorKey: _rootNavigatorKey,
                      name: RouteNames.productivity,
                      path: 'productivity',
                      builder: (context, state) {
                        return const ProductivityScreen();
                      },
                    ),
                  ]),
                ]),

          ]),
    ]);

// String? redirect()  {
//   String route = '/';
//   BlocListener<IsLoggedInBloc, IsLoggedInState>(
//     listener: (context, state) {
//       if (state is IsLoggedInDataState) {
//         if (state.isLoggedIn) {
//           route ='/show_categories';
//         }
//       }
//     },
//   );
//   return route;
// }
