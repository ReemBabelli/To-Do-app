import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/language/cubits/locale_cubit.dart';
import 'package:to_do_app/features/auth/presentation/blocs/auth/auth_blocs.dart';
import 'package:to_do_app/features/category/presentation/blocs/CategoryOperationsBloc/category_operations_blocs.dart';
import 'package:to_do_app/features/task/presentation/blocs/task_operations_bloc/task_operations_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/utilities/router.dart';
import 'features/auth/presentation/blocs/is_logged_in_bloc/is_logged_in_bloc.dart';
import 'features/category/presentation/blocs/CategoriesBloc/categories_blocs.dart';
import 'features/task/presentation/blocs/Tasks_bloc/tasks_bloc.dart';
import 'core/utilities/injection_container.dart' as di;

Client client = Client();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  client
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('6526af23c9e5afd54062')
      .setSelfSigned(status: true);
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<AuthBloc>()),
          BlocProvider(create: (_) => di.sl<CategoryOperationsBloc>()),
          BlocProvider(create: (_) => di.sl<CategoriesBloc>()),
          BlocProvider(create: (_) => di.sl<TaskOperationsBloc>()),
          BlocProvider(create: (_) => di.sl<TasksBloc>()),
          BlocProvider(
              create: (_) => di.sl<IsLoggedInBloc>()..add(IsLoggedInEvent())),
          BlocProvider(create: (_) => di.sl<LocaleCubit>()..getCachedLanguage)
        ],
        child: BlocProvider(
          create: (context) => di.sl<LocaleCubit>()..getSavedLanguage(),
          child:
              BlocBuilder<LocaleCubit, LocaleStates>(builder: (context, state) {
            if (state is ChangeLocaleState) {
              //var defaultLanguage = state.locale;
              return MaterialApp.router(
                routerConfig: router,
                builder: (context, child) =>
                    ResponsiveBreakpoints.builder(child: child!, breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  const Breakpoint(
                      start: 1921, end: double.infinity, name: '4k'),
                ]),
                locale: state.locale,
                //localizationsDelegates : support widget directions and languages
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                //supportedLocales: contains languages
                supportedLocales: AppLocalizations.supportedLocales,
                // localeResolutionCallback: give language linked to conditions
                localeResolutionCallback: (deviceLocale, languageCode) {
                  for (var locale in AppLocalizations.supportedLocales) {
                    if (deviceLocale != null &&
                        deviceLocale.languageCode == locale.languageCode) {
                      return deviceLocale;
                    }
                  }
                  return AppLocalizations.supportedLocales[0];
                },
                debugShowCheckedModeBanner: false,
                title: 'To-Do App',
                theme: ThemeData(
                  fontFamily: state.locale ==
                          AppLocalizations.supportedLocales[0]
                      ? 'El_Messiri'
                      : 'Playpen_Sans',
                  useMaterial3: true,
                  primarySwatch: Colors.blueGrey,
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
        ));
  }
}
