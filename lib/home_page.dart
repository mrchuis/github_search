import 'package:flutter/material.dart';
import 'package:github_search/common/app_icons.dart';
import 'package:github_search/feature/search_bloc/presentation/widgets/search_widget.dart';
import 'package:github_search/feature/search_bloc/presentation/widgets/search_widget_rx.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GitHub Search App'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: AppIcons.blocIcon,
              ),
              Tab(
                icon: AppIcons.rxIcon,
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            SearchWidget(),
            SearchWidgetRx(),
          ],
        ),
      ),
    );
  }
}
