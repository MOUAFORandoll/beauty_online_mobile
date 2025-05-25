import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/widgets/empty_builder.dart';
import 'package:beauty/home/models/search_result.dart';
import 'package:beauty/home/services/actu_service.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/auto_list/bloc/auto_list_cubit.dart';

import 'package:potatoes/auto_list/widgets/auto_list_view.dart';

class MySearchDelegate extends SearchDelegate<String> {
  late final AutoListCubit<SearchResult> _cubit;
  final ActuService _actuService;

  MySearchDelegate(BuildContext context)
      : _actuService = context.read<ActuService>() {
    _cubit = AutoListCubit(
      provider: ({page = 1}) => _actuService.search(
        search: query,
        page: page,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          _cubit.reset();
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  String? get searchFieldLabel => 'Rechercher…';

  @override
  PreferredSizeWidget? buildBottom(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size.fromHeight(1.0),
      child: Divider(
        height: 5.0,
        color: Color(0xffD9D9D9),
      ),
    );
  }

  @override
  TextStyle? get searchFieldStyle => const TextStyle(fontSize: 14.0);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        titleTextStyle: theme.textTheme.bodyMedium?.copyWith(
          color: const Color(0xffD9D9D9),
        ),
        toolbarTextStyle: theme.textTheme.bodyMedium,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: theme.textTheme.bodySmall,
        border: InputBorder.none,
        helperStyle: theme.textTheme.bodySmall,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Container();
    }
    _cubit.reset();
    return _buildListView(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 3) {
      return Container();
    }
    _cubit.reset();
    return _buildListView(context);
  }

  Widget _buildListView(BuildContext context) {
    return AutoListView.get<SearchResult>(
      cubit: _cubit,
      shrinkWrap: true,
      autoManage: false,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, searchResult) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              Container(
                height: 88,
                width: 72,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image(
                  fit: BoxFit.cover,
                  image:
                      context.read<AppCacheManager>().getImage(searchResult.url),
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    if (frame != null) return child;
                    return Container(
                      width: 72,
                      height: 88,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      child: wasSynchronouslyLoaded
                          ? child
                          : Center(
                              child: SizedBox(
                                height: 16.0,
                                width: 16.0,
                                child: CircularProgressIndicator(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onTertiaryContainer,
                                  strokeWidth: 2.0,
                                ),
                              ),
                            ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      searchResult.title,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      emptyBuilder: (ctx) => const EmptyBuilder(),
      errorBuilder: (context, retry) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Une erreur s'est produite"),
            TextButton(
              onPressed: retry,
              child: const Text("Réessayer"),
            )
          ],
        ),
      ),
      loadingBuilder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      loadingMoreBuilder: (context) => Container(
        padding: const EdgeInsets.only(top: 16, bottom: 28)
            .add(const EdgeInsets.symmetric(horizontal: 16)),
        child: LinearProgressIndicator(
          color: Theme.of(context).colorScheme.onTertiaryContainer,
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
