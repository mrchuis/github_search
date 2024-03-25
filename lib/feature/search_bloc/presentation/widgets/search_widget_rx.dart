import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/feature/search_bloc/data/models/search_result.dart';
import 'package:github_search/feature/search_bloc/presentation/bloc/bloc.dart';

class SearchWidgetRx extends StatelessWidget {
  const SearchWidgetRx({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          TextField(
            controller: context.read<SearchBloc>().controllerRx,
            onChanged: (value) => context.read<SearchBloc>().searchText(value),
            decoration: const InputDecoration(
              hintText: 'Поиск...',
            ),
          ),
          Expanded(
            child: StreamBuilder<SearchResult?>(
              stream: context.read<SearchBloc>().results,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final result = snapshot.data;

                  if (result is SearchResultWithError) {
                    return const Center(child: Text('Ошибка'));
                  } else if (result is SearchResultLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (result is SearchResultNoResult) {
                    return const Center(child: Text('Результат не найден'));
                  } else if (result is SearchResultWithResult) {
                    final results = result.result;
                    return ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final repository = results[index];
                        return ListTile(
                          title: Text(repository.htmlUrl ?? ""),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text("Неизвестная ошибка"));
                  }
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
