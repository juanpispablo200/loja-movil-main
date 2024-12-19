import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/domain/usecase/events_usecase.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/presentation/common/empty_data.widget.dart';
import 'package:loja_movil/src/presentation/common/event_card.widget.dart';
import 'package:loja_movil/src/presentation/common/tab_bar_custom.widget.dart';
import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';
import 'package:loja_movil/src/presentation/cultural_agenda/events/events_bloc.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  static init(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EventsBLoC(
            useCase: EventsUseCase(
              apiRepositoryInterface: context.read<ApiRepository>(),
            ),
          )..init(),
          builder: (_, __) => const EventsScreen(),
        ),
      ],
    );
  }

  static const routeName = '/events';
  static const String name = 'events-screen';

  @override
  State<EventsScreen> createState() => _EventsScreen();
}

class _EventsScreen extends State<EventsScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<EventsBLoC>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cultureFiavEvents,
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
              height: 40,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(
              height: 45,
              child: TabBarCustom(
                selectedColor: kPrimaryColor,
                unselectedColor: kPrimaryColor.withOpacity(0.2),
                items: [
                  TabBarCustomItem(
                    label: AppLocalizations.of(context)!.cultureEventsSelectorAll,
                  ),
                  TabBarCustomItem(
                    label: AppLocalizations.of(context)!.cultureEventsSelectorNow,
                  ),
                  TabBarCustomItem(
                    label: AppLocalizations.of(context)!.cultureEventsSelectorNext,
                  ),
                  TabBarCustomItem(
                    label: _selectedDay != null
                        ? _selectedDay.toString().substring(0, 10)
                        : AppLocalizations.of(context)!
                            .cultureEventsSelectorCalendar,
                  ),
                ],
                onSelect: (selectedIndex) async {
                  if (selectedIndex == 3) {
                    // Opcion 3 calendario
                    await _showCalendar();
                    bloc.loadEvents(selectedIndex, _selectedDay);
                  } else {
                    setState(() {
                      _selectedDay = null;
                    });
                    bloc.loadEvents(selectedIndex, _selectedDay);
                  }
                },
              ),
            ),
            SizedBox(
              height: 40.0,
              child: Row(
                children: [
                  const Icon(Icons.search_outlined),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    AppLocalizations.of(context)!.cultureFiavEvents,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: bloc.loading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const SizedBox(height: 150),
                          );
                        },
                      ),
                    )
                  : bloc.eventos.isNotEmpty
                      ? ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20.0,
                            );
                          },
                          padding: const EdgeInsets.only(bottom: 30.0),
                          itemBuilder: (context, index) {
                            Evento evento = bloc.eventos[index];
                            return EventCard(evento: evento);
                          },
                          itemCount: bloc.eventos.length,
                        )
                      : EmptyData(
                          title: AppLocalizations.of(context)!
                              .cultureNoEvents),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCalendar() async {
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
              });
              context.pop();
            },
          ),
        );
      },
    );
  }
}
