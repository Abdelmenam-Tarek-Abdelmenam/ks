import 'package:final_projects/data/models/product.dart';
import 'package:final_projects/data/models/tournament.dart';
import 'package:flutter/material.dart';

import '../../data/models/matches.dart';

import '../view/customer_support_view/customer_support_view.dart';
import '../view/landing_view/landing_view.dart';
import '../view/login_view/login_view.dart';
import '../view/play_view/ground_details_view.dart';
import '../view/play_view/matches_view.dart';

import '../view/play_view/product_view.dart';
import '../view/tournaments_view/tournaments_view.dart';
import '../view/tournaments_view/widgets/tournaments_details.dart';
import '../view/tournaments_view/widgets/video_show.dart';
import '../view/user_info_view/user_info_view.dart';

class Routes {
  static const String login = "/login";
  static const String landing = "/";
  static const String home = "/home";
  static const String user = "/user";
  static const String match = "/matches";
  static const String tournaments = "/tournaments";
  static const String customerSupport = "/customerSupport";
  static const String groundDetails = "/GroundDetailsView";
  static const String tournamentsDetails = "/tournamentsDetails";
  // static const String product = "/product";
  static const String video = "/video";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.landing:
        return MaterialPageRoute(
            builder: (_) => const LandingView(HomePageStates.splash));
      case Routes.home:
        return MaterialPageRoute(
            builder: (_) => const LandingView(HomePageStates.landing));
      case Routes.match:
        return MaterialPageRoute(builder: (_) => MatchesView());
      case Routes.customerSupport:
        return MaterialPageRoute(builder: (_) => const CustomerSupportView());
      case Routes.tournaments:
        return MaterialPageRoute(builder: (_) => TournamentsView());
      case Routes.user:
        return MaterialPageRoute(builder: (_) => UserInfoView());
      case Routes.groundDetails:
        return MaterialPageRoute(
            builder: (_) => GroundDetailsView(settings.arguments as Ground));
      // case Routes.product:
        // return MaterialPageRoute(
        //     builder: (_) => ProductView(settings.arguments as Product));
      case Routes.tournamentsDetails:
        return MaterialPageRoute(
            builder: (_) =>
                TournamentsDetails(settings.arguments as Tournament));
      case Routes.video:
        return MaterialPageRoute(builder: (_) => const VideoShowPage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("No Route Found"),
              ),
              body: const Center(child: Text("No Route Found")),
            ));
  }
}
