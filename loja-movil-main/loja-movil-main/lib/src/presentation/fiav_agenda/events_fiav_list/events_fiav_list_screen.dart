import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/presentation/common/loading_view.dart';
import 'package:loja_movil/src/domain/model/dto/event_fav_aux_dto.dart';
import 'package:loja_movil/src/presentation/common/fiav_app_bar.widget.dart';
import 'package:loja_movil/src/domain/usecase/fiav_events_list_usecase.dart';
import 'package:loja_movil/src/presentation/common/event_fiav_card_by_date.widget.dart';
import 'package:loja_movil/src/presentation/fiav_agenda/events_fiav_list/events_fiav_list_bloc.dart';

class EventsFiavListScreen extends StatefulWidget {
  const EventsFiavListScreen({super.key});

  static Widget init(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EventsFiavListBLoC(
            useCase: FiavEventsListUsecase(
              apiRepositoryInterface: context.read<ApiRepository>(),
            ),
          )..init(),
          builder: (_, __) => const EventsFiavListScreen(),
        )
      ],
    );
  }

  static const routeName = '/events-fiav-list';

  static const String name = 'event-fiav-list-screen';

  @override
  State<EventsFiavListScreen> createState() => _EventsFiavListScreen();
}

class _EventsFiavListScreen extends State<EventsFiavListScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<EventsFiavListBLoC>();
    return LoadingView(
      isLoading: bloc.loading,
      appBar:
          FiavAppBar(title: AppLocalizations.of(context)!.cultureFiavEvents),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                InkWell(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                      color: kFavPrimary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.fiavEventsSelectorAll,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedDay = null;
                    });
                    bloc.getAllEvents();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6),
                      ),
                      color: kFavPrimary.withOpacity(0.8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(
                        _selectedDay != null
                            ? _selectedDay.toString().substring(0, 10)
                            : AppLocalizations.of(context)!
                                .fiavEventsSelectorCalendar,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    _showCalendar(bloc);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: bloc.eventsAux.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        EventFavAuxDTO event = bloc.eventsAux[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: EventFiavCardByDate(
                            event: event,
                          ),
                        );
                      },
                      itemCount: bloc.eventsAux.length,
                    )
                  : Center(
                      child: Text(
                      AppLocalizations.of(context)!.cultureNoEvents,
                      style: const TextStyle(
                          color: kFavPrimary,
                          fontWeight: FontWeight.w900,
                          fontSize: 14),
                    )),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCalendar(EventsFiavListBLoC bloc) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                bloc.getEventsByDate(_selectedDay!);
              });
              context.pop();
            },
          ),
        );
      },
    );
  }
}
