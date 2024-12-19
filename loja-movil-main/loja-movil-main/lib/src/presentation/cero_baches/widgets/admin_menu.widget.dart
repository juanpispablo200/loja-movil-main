import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/src/libraries/go_router_extension.dart';
import 'package:loja_movil/src/presentation/cero_baches/pages/home_page.dart';
import 'package:loja_movil/src/presentation/cero_baches/state/cero_baches_state.dart';

class AdminMenu extends StatelessWidget {
  final CeroBachesStateBLoC provider;

  const AdminMenu({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              const Icon(Icons.person),
              const SizedBox(
                width: 10,
              ),
              Text(
                  '${provider.userAccount!.firstName} ${provider.userAccount!.lastName}')
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              const Icon(Icons.email),
              const SizedBox(
                width: 10,
              ),
              Text(provider.userAccount!.email)
            ],
          ),
        ),
        // PopupMenuItem(
        //   value: 3,
        //   child: Row(
        //     children: [
        //       const Icon(Icons.home_work),
        //       const SizedBox(
        //         width: 10,
        //       ),
        //       Text((provider.account!.authorities
        //                   .contains(roles['ROLE_SUPER_ADMIN']) ||
        //               provider.account!.authorities
        //                   .contains(roles['ROLE_ADMIN']))
        //           ? "[Administrador]"
        //           : provider.department == null
        //               ? "Sin departamento"
        //               : provider.department!.name)
        //     ],
        //   ),
        // ),
        PopupMenuItem(
          value: 3,
          child: const Row(
            children: [
              Icon(Icons.logout),
              SizedBox(
                width: 10,
              ),
              Text("Cerrar Sesión")
            ],
          ),
          onTap: () async {
            provider.logout();
            GoRouter.of(context)
                .popUntilPath(context, CeroBachesHomePage.routeName);
          },
        ),
      ],
      offset: const Offset(0, 50),
      color: Colors.white,
      icon: const Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      elevation: 1,
    );
  }
}
