import 'package:go_router/go_router.dart';
import 'package:loja_movil/src/domain/model/dto/event_fav_detail_dto.dart';
import 'package:loja_movil/src/domain/response/events_fav_by_local_response.dart';
import 'package:loja_movil/src/domain/response/route_response.dart';
import 'package:loja_movil/src/presentation/MenuPages/about_us.dart';
import 'package:loja_movil/src/presentation/MenuPages/frequent_questions.dart';
import 'package:loja_movil/src/presentation/MenuPages/language.dart';
import 'package:loja_movil/src/presentation/cero_baches/pages/admin_page.dart';
import 'package:loja_movil/src/presentation/cero_baches/pages/attend_incidence_page.dart';
import 'package:loja_movil/src/presentation/cero_baches/pages/home_page.dart';
import 'package:loja_movil/src/presentation/cero_baches/pages/login_page.dart';
import 'package:loja_movil/src/presentation/cero_baches/pages/new_report_page.dart';
import 'package:loja_movil/src/presentation/cero_baches/pages/update_incidence_page.dart';
import 'package:loja_movil/src/presentation/cero_baches/state/cero_baches_state.dart';
import 'package:loja_movil/src/presentation/cultural_agenda/cultural_agenda_home/cultural_agenda_home_screen.dart';
import 'package:loja_movil/src/presentation/cultural_agenda/event_detail/event_detail_screen.dart';
import 'package:loja_movil/src/presentation/cultural_agenda/events/events_screen.dart';
import 'package:loja_movil/src/presentation/cultural_agenda/local_events_detail/local_event_detail_screen.dart';
import 'package:loja_movil/src/presentation/cultural_agenda/locals_home/locals_home_screen.dart';
import 'package:loja_movil/src/presentation/fiav_agenda/event_detail_fiav/event_detail_fiav_screen.dart';
import 'package:loja_movil/src/presentation/fiav_agenda/events_fiav_list/events_fiav_list_screen.dart';
import 'package:loja_movil/src/presentation/fiav_agenda/fiav_agenda_home/fiav_agenda_home_screen.dart';
import 'package:loja_movil/src/presentation/fiav_agenda/local_events_fiav_detail/local_events_fiav_detail_screen.dart';
import 'package:loja_movil/src/presentation/fiav_agenda/locals_fiav_home/locals_fiav_home_screen.dart';
import 'package:loja_movil/src/presentation/home/home_screen.dart';
import 'package:loja_movil/src/presentation/login_app/login_app_page.dart';
import 'package:loja_movil/src/presentation/splash/splash_screen.dart';
import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';
import 'package:loja_movil/src/presentation/tourism/localities_list/localities_list_screen.dart';
import 'package:loja_movil/src/presentation/tourism/locality_route_detail/locality_route_detail_screen.dart';
import 'package:loja_movil/src/presentation/tourism/route_map/route_map_screen.dart';
import 'package:loja_movil/src/presentation/tourism/tourism_home/tourism_home_screen.dart';
import 'package:loja_movil/src/presentation/tourism/tourism_route_home/tourism_route_home_screen.dart';
import 'package:provider/provider.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: SplashScreen.name,
      builder: (context, state) {
        return SplashScreen.init(context);
      },
    ),
    GoRoute(
      path: LoginAppPage.routeName,
      name: LoginAppPage.name,
      builder: (context, state) {
        return const LoginAppPage();
      },
      // redirect: (context, state) {
      //   final provider = context.read<CeroBachesStateBLoC>();
      //   if (!provider.isAuthenticated) {
      //     return LoginAppPage.routeName;
      //   }
      //   return null;
      // },
    ),
    GoRoute(
      path: HomeScreen.routeName,
      name: HomeScreen.name,
      builder: (context, state) {
        return HomeScreen.init(context);
      },
    ),
    GoRoute(
      path: CulturalAgendaHomeScreen.routeName,
      name: CulturalAgendaHomeScreen.name,
      builder: (context, state) {
        return CulturalAgendaHomeScreen.init(context);
      },
    ),
    GoRoute(
      path: '${LocalEventDetailScreen.routeName}/:lugarId',
      name: LocalEventDetailScreen.name,
      builder: (context, state) {
        final lugarId = state.pathParameters['lugarId'] ?? '-1';
        return LocalEventDetailScreen.init(
          context: context,
          lugarId: int.parse(lugarId),
        );
      },
    ),
    GoRoute(
      path: LocalsHomeScreen.routeName,
      name: LocalsHomeScreen.name,
      builder: (context, state) {
        return LocalsHomeScreen.init(context: context);
      },
    ),
    GoRoute(
      path: EventsScreen.routeName,
      name: EventsScreen.name,
      builder: (context, state) {
        return EventsScreen.init(context);
      },
    ),
    GoRoute(
      path: EventDetailScreen.routeName,
      name: EventDetailScreen.name,
      builder: (context, state) {
        final evento = GoRouterState.of(context).extra as Evento;
        return EventDetailScreen.init(context: context, evento: evento);
      },
    ),
    GoRoute(
      path: FiavAgendaHomeScreen.routeName,
      name: FiavAgendaHomeScreen.name,
      builder: (context, state) {
        return FiavAgendaHomeScreen.init(context);
      },
    ),
    GoRoute(
      path: LocalsFiavHomeScreen.routeName,
      name: LocalsFiavHomeScreen.name,
      builder: (context, state) {
        return LocalsFiavHomeScreen.init(context);
      },
    ),
    GoRoute(
      path: LocalEventsFiavDetailScreen.routeName,
      name: LocalEventsFiavDetailScreen.name,
      builder: (context, state) {
        final local = GoRouterState.of(context).extra as LocalFav;
        return LocalEventsFiavDetailScreen.init(
          context: context,
          local: local,
        );
      },
    ),
    GoRoute(
      path: EventDetailFiavScreen.routeName,
      name: EventDetailFiavScreen.name,
      builder: (context, state) {
        final evento = GoRouterState.of(context).extra as EventFavDetailDTO;
        return EventDetailFiavScreen.init(context: context, evento: evento);
      },
    ),
    GoRoute(
      path: EventsFiavListScreen.routeName,
      name: EventsFiavListScreen.name,
      builder: (context, state) {
        return EventsFiavListScreen.init(context);
      },
    ),
    GoRoute(
      path: FrequentQuestions.routeName,
      name: FrequentQuestions.name,
      builder: (context, state) {
        return const FrequentQuestions();
      },
    ),
    GoRoute(
      path: LanguagePage.routeName,
      name: LanguagePage.name,
      builder: (context, state) {
        return const LanguagePage();
      },
    ),
    GoRoute(
      path: AboutUs.routeName,
      name: AboutUs.name,
      builder: (context, state) {
        return const AboutUs();
      },
    ),
    // Inicio Incidencias
    GoRoute(
      path: LoginPage.routeName,
      name: LoginPage.name,
      builder: (context, state) {
        return const LoginPage();
      },
      redirect: (context, state) {
        final provider = context.read<CeroBachesStateBLoC>();
        if (!provider.isAuthenticated) {
          return LoginPage.routeName;
        }
        return null;
      },
    ),
    GoRoute(
      path: AdminPage.routeName,
      name: AdminPage.name,
      builder: (context, state) {
        return const AdminPage();
      },
      redirect: (context, state) {
        final provider = context.read<CeroBachesStateBLoC>();
        if (!provider.isAuthenticated) {
          return LoginPage.routeName;
        }
        return null;
      },
    ),
    GoRoute(
      path: '${UpdateIncidencePage.routeName}/:incidenceId',
      name: UpdateIncidencePage.name,
      builder: (context, state) {
        final incidenceId = state.pathParameters['incidenceId'] ?? '-1';
        return UpdateIncidencePage(
          incidenceId: int.parse(incidenceId),
        );
      },
      redirect: (context, state) {
        final provider = context.read<CeroBachesStateBLoC>();
        if (!provider.isAuthenticated) {
          return LoginPage.routeName;
        }
        return null;
      },
    ),
    GoRoute(
      path: '${AttendIncidencePage.routeName}/:incidenceId',
      name: AttendIncidencePage.name,
      builder: (context, state) {
        final incidenceId = state.pathParameters['incidenceId'] ?? '-1';
        return AttendIncidencePage(
          incidenceId: int.parse(incidenceId),
        );
      },
      redirect: (context, state) {
        final provider = context.read<CeroBachesStateBLoC>();
        if (!provider.isAuthenticated) {
          return LoginPage.routeName;
        }
        return null;
      },
    ),
    GoRoute(
      path: CeroBachesHomePage.routeName,
      name: CeroBachesHomePage.name,
      builder: (context, state) {
        return const CeroBachesHomePage();
      },
    ),
    GoRoute(
      path: NewReportPage.routeName,
      name: NewReportPage.name,
      builder: (context, state) {
        return const NewReportPage();
      },
    ),
    GoRoute(
      path: TourismHomeScreen.routeName,
      name: TourismHomeScreen.name,
      builder: (context, state) {
        return TourismHomeScreen.init(context);
      },
    ),
    GoRoute(
      path: '${TourismRouteHomeScreen.routeName}/:routeId',
      name: TourismRouteHomeScreen.name,
      builder: (context, state) {
        final routeId = state.pathParameters['routeId'] ?? '-1';
        return TourismRouteHomeScreen.init(
          context: context,
          routeId: int.parse(routeId),
        );
      },
    ),
    GoRoute(
      path: RouteMapScreen.routeName,
      name: RouteMapScreen.name,
      builder: (context, state) {
        final route = GoRouterState.of(context).extra as FullRoute;
        return RouteMapScreen.init(context: context, route: route);
      },
    ),
    GoRoute(
      path: '${LocalityRouteDetailScreen.routeName}/:localityId',
      name: LocalityRouteDetailScreen.name,
      builder: (context, state) {
        final localityId = state.pathParameters['localityId'] ?? '-1';
        return LocalityRouteDetailScreen.init(
            context: context, localityId: int.parse(localityId));
      },
    ),
    GoRoute(
      path: LocalitiesListHomeScreen.routeName,
      name: LocalitiesListHomeScreen.name,
      builder: (context, state) {
        return LocalitiesListHomeScreen.init(context);
      },
    ),
  ],
);
