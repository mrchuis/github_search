import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/feature/search_bloc/presentation/bloc/bloc.dart';
import 'package:github_search/home_page.dart';
import 'package:github_search/service_locator.dart' as di;
import 'package:github_search/service_locator.dart';

void main() => runZonedGuarded<void>(
  () async {
    await di.init();

    return runApp(const MyApp());
  },
  (error, stack) {
    debugPrint("$error");
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<SearchBloc>(
        create: (context) => sl<SearchBloc>(),
        child: const HomePage(),
      ),
    );
  }
}
