import 'dart:convert';

import 'package:final_projects/bloc/matches_bloc/matches_bloc.dart';
import 'package:final_projects/bloc/tournament_bloc/tournament_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc/auth_status_bloc.dart';
import 'bloc/my_bloc_observer.dart';


import 'bloc/user_info_bloc/user_info_status_bloc.dart';
import 'data/data_sources/pref_repository.dart';
import 'data/models/app_user.dart';
import 'presentation/resources/routes_manger.dart';
import 'presentation/resources/string_manager.dart';
import 'presentation/resources/theme/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceRepository.init();
  
  Bloc.observer = MyBlocObserver();

  String? userData = PreferenceRepository.getData(key: PreferenceKey.userData);
  AppUser? user =
      userData == null ? null : AppUser.fromJson(json.decode(userData));
  runApp(MyApp(user));
  
}

class MyApp extends StatelessWidget {
  const MyApp(this.user, {super.key});
  final AppUser? user;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(user), lazy: false),
          BlocProvider(create: (context) => UserInfoBloc()),
          BlocProvider(create: (context) => TournamentBloc()),
          BlocProvider(create: (context) => PlayBloc()),
        ],
        child: Directionality(
          textDirection : TextDirection.rtl,
          child: MaterialApp(
            title: StringManger.appName,
            theme: lightThemeData,
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: user != null ? Routes.login : Routes.landing,
            // ),
          ),
        ),
      );
}
