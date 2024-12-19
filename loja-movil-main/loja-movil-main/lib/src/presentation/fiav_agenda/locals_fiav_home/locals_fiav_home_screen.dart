import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/presentation/common/loading_view.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/domain/usecase/fiav_locals_home_usecase.dart';
import 'package:loja_movil/src/presentation/common/fiav_app_bar.widget.dart';
import 'package:loja_movil/src/presentation/common/local_fav_card.widget.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_local_response.dart';
import 'package:loja_movil/src/presentation/fiav_agenda/locals_fiav_home/locals_fiav_home_bloc.dart';

class LocalsFiavHomeScreen extends StatelessWidget {
  const LocalsFiavHomeScreen._();

  static Widget init(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocalsFiavHomeBLoC(
            useCase: FiavLocalsHomeUseCase(
              apiRepositoryInterface: context.read<ApiRepository>(),
            ),
          )..init(),
          builder: (_, __) => const LocalsFiavHomeScreen._(),
        ),
      ],
    );
  }

  static const routeName = '/locals-fiav-home';
  static const String name = 'locals-fiav-home-page';

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LocalsFiavHomeBLoC>();
    return LoadingView(
      isLoading: bloc.loading,
      appBar: FiavAppBar(
        title: AppLocalizations.of(context)!.cultureFiavLocalities,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
        child: Column(
          children: [
            TextField(
              cursorWidth: 0.6,
              cursorColor: Colors.black,
              textAlignVertical: TextAlignVertical.center,
              onChanged: (value) {
                bloc.setCriteria(value);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                fillColor: const Color(0xFFF4F6F9),
                filled: true,
                hintText: AppLocalizations.of(context)!.commonSearch,
                hintStyle: const TextStyle(
                  color: Color(0XFF747B84),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: kFavSecondary,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                ),
                itemCount: bloc.localsFiltered.length,
                itemBuilder: (context, index) {
                  LocalFav loc = bloc.localsFiltered[index];
                  return LocalFavCard(
                    local: loc,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
