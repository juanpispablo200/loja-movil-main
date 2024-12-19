// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/src/presentation/home/home_screen.dart';
import 'package:loja_movil/src/domain/usecase/splash_usecase.dart';
import 'package:loja_movil/src/presentation/splash/splash_bloc.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/presentation/common/loading_icon.widget.dart';
import 'package:loja_movil/src/domain/repository/local_storage_repository.dart';
import 'package:loja_movil/src/domain/repository/database_local_repository.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  static const name = 'splash-page';
  const SplashScreen._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashBLoC(
        useCase: SplashUseCase(
          repository: context.read<DatabaseLocalRepository>(),
          apiRepository: context.read<ApiRepository>(),
          localRepositoryInterface: context.read<LocalRepositoryInterface>(),
        ),
      ),
      builder: (_, __) => const SplashScreen._(),
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _init() async {
    final bloc = context.read<SplashBLoC>();
    await bloc.init();
    context.go(HomeScreen.routeName);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(
        const AssetImage('assets/images/portada-splash.jpg'), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/portada-splash.jpg'),
            const Spacer(),
            Text(
              "Bienvenido a",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20.0),
            ),
            Container(
              width: 180.0,
              padding: const EdgeInsets.only(top: 20.0),
              child: Image.asset('assets/images/loja-en-linea-blue.png'),
            ),
            const SizedBox(
              height: 70.0,
            ),
            const LoadingIcon(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
