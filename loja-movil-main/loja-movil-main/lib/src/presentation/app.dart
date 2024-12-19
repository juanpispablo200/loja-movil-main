import 'package:flutter/material.dart';
import 'package:loja_movil/src/domain/usecase/alfresco_usecase.dart';
import 'package:loja_movil/src/domain/usecase/cero_baches_usecase.dart';
import 'package:loja_movil/src/presentation/cero_baches/state/cero_baches_state.dart';
import 'package:provider/provider.dart';
import 'package:loja_movil/constants.dart';
import 'package:loja_movil/src/config/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/presentation/state/locale_provider.dart';
import 'package:loja_movil/src/data/datasource/api_repository_impl.dart';
import 'package:loja_movil/src/data/datasource/local_repository_impl.dart';
import 'package:loja_movil/src/domain/repository/local_storage_repository.dart';
import 'package:loja_movil/src/domain/repository/database_local_repository.dart';
import 'package:loja_movil/src/data/datasource/database_local_repository_impl.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiRepository>(
          create: (_) => ApiRepositoryImpl(),
        ),
        Provider<LocalRepositoryInterface>(
          create: (_) => LocalRepositoryImpl(),
        ),
        Provider<DatabaseLocalRepository>(
          create: (_) => DatabaseLocalRepositoryImpl(),
        ),
        ChangeNotifierProvider<CeroBachesStateBLoC>(
          create: (context) => CeroBachesStateBLoC(
            useCase: CeroBachesUseCase(
              apiRepositoryInterface: context.read<ApiRepository>(),
            ),
            alfrescoUseCase: AlfrescoUseCase(
              apiRepositoryInterface: context.read<ApiRepository>(),
            ),
          ),
        ),
         ChangeNotifierProvider<LocaleProvider>(
          create: (context) => LocaleProvider(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final localeProvider = Provider.of<LocaleProvider>(context);
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            restorationScopeId: 'app',
            locale: localeProvider.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.homeTitle,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.white,
                primary: kPrimaryColor,
                secondary: kSecondaryColor,
              ),
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black),
                color: Colors.white,
                elevation: 0,
                shadowColor: Colors.transparent,
                surfaceTintColor:
                    Colors.transparent,
              ),
              scaffoldBackgroundColor:
                  Colors.white,
              fontFamily: 'Avenir',
            ),
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
