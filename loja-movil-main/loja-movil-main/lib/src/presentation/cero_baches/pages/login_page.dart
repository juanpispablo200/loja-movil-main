import 'package:flutter/material.dart';
import '../../common/loading_view.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:loja_movil/src/presentation/cero_baches/pages/admin_page.dart';
import 'package:loja_movil/src/presentation/cero_baches/state/cero_baches_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/cero_baches_login';
  static const String name = 'login-page';

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CeroBachesStateBLoC>(context);
    final height = MediaQuery.of(context).size.height;

    return LoadingView(
      isLoading: provider.loadingAccount,
      backgroundColor: const Color(0XFFFFFFFF),
      appBar: AppBar(
          title: const Text(
            'Iniciar Sesión',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          backgroundColor: const Color(0XFFFFFFFF),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => GoRouter.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kBlackColor,
            ),
          )),
      child: SafeArea(
        child: SizedBox(
          height: height,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * 0.05),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Image.asset(
                          'assets/images/escudo.png',
                          height: 90,
                        ),
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                            text: 'Bienvenido de regreso\n',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      "Ingresa las credenciales para continuar",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey,
                                  ))
                            ]),
                      ),
                      const SizedBox(height: 50),
                      Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Usuario',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        fillColor: Color(0xfff3f3f4),
                                        filled: true))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Contraseña',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: passController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Color(0xfff3f3f4),
                                      filled: true),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width * 1, 45),
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () async {
                          var loginStatus = await provider.loginKeycloak(
                              emailController.text.trim(), passController.text);
                          if (loginStatus == null) {
                            if (mounted) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Center(
                                      child: Text(
                                          'Usuario o contraseña incorrecto')),
                                  backgroundColor:
                                      Color.fromARGB(255, 150, 15, 0),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(50),
                                  elevation: 30,
                                ),
                              );
                            }
                          } else {
                            if (mounted) {
                              // ignore: use_build_context_synchronously
                              context.pushReplacement(AdminPage.routeName);
                            }
                          }
                        },
                        child: const Text(
                          'Iniciar Sesión',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
