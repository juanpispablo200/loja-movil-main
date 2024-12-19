import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/domain/usecase/locals_home_usecase.dart';
import 'package:loja_movil/src/presentation/common/empty_data.widget.dart';
import 'package:loja_movil/src/presentation/common/lugar_card.widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loja_movil/src/presentation/cultural_agenda/locals_home/locals_home_bloc.dart';

class LocalsHomeScreen extends StatelessWidget {
  const LocalsHomeScreen._();

  static Widget init({
    required BuildContext context,
  }) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocalsHomeBLoC(
            useCase: LocalsHomeUseCase(
              apiRepositoryInterface: context.read<ApiRepository>(),
            ),
          )..init(),
          builder: (_, __) => const LocalsHomeScreen._(),
        ),
      ],
    );
  }

  static const routeName = '/locals-home';
  static const String name = 'locals-home-screen';

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LocalsHomeBLoC>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cultureFiavLocalities,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Image.asset(
              'assets/images/escudo.png',
              height: 40.0,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              cursorWidth: 0.6,
              cursorColor: Colors.black,
              textAlignVertical: TextAlignVertical.center,
              onChanged: (value) {
                bloc.setCriteria(value);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
                hintText: AppLocalizations.of(context)!.commonSearch,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only (
                  left: 20.0, right: 20.0, bottom: 10.0
                ),
                child: bloc.lugarFiltered.isNotEmpty
                    ? StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: [
                          ...bloc.lugarFiltered.map(
                            (lugar) => StaggeredGridTile.count(
                              crossAxisCellCount: 1,
                              mainAxisCellCount: 1.4,
                              child: LugarCard(
                                lugar: lugar,
                              ),
                            ),
                          )
                        ],
                      )
                    : EmptyData(
                        title: AppLocalizations.of(context)!.cultureNoLocalities),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  });

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? Colors.amber,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}
