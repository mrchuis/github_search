import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/common/status_state.dart';
import 'package:github_search/feature/search_bloc/presentation/bloc/bloc.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              TextField(
                controller: context.read<SearchBloc>().controller,
                decoration: const InputDecoration(
                  hintText: 'Поиск...',
                ),
              ),
              if (state.statusState!.isLoaded() && state.searchList != null && state.searchList!.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: state.searchList!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.searchList![index]),
                      );
                    },
                  ),
                ),
                if (state.statusState!.isLoading())
                  const Padding(
                    padding: EdgeInsets.only(top: 64.0),
                    child: CircularProgressIndicator(),
                  ),
            ],
          ),
        );
      },
    );
  }
}
