import 'package:beauty/my_pro/bloc/load_me_catalogue_cubit.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/my_pro/widgets/my_item_catalogue.dart';
import 'package:beauty/common/models/service_model.dart';
import 'package:beauty/common/widgets/empty_builder.dart';
import 'package:beauty/common/widgets/error_builder.dart';
import 'package:beauty/common/widgets/loader_builder.dart';
import 'package:beauty/common/widgets/section_title.dart';
import 'package:beauty/common/widgets/service_item.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/auto_content/widgets/auto_content_view.dart';
import 'package:potatoes/auto_list.dart';
import 'package:potatoes/libs.dart';

class CatalogueView extends StatefulWidget {
  const CatalogueView({super.key});

  @override
  State<CatalogueView> createState() => _CatalogueViewState();
}

class _CatalogueViewState extends State<CatalogueView> {
  late final cubit = context.read<LoadMeCatalogueCubit>();

  @override
  Widget build(BuildContext context) {
    return AutoListView.get<Catalogue>(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
        cubit: cubit,
        viewType: ViewType.grid,
        itemBuilder: (context, catalogue) => MyCatalogueItem(catalogue),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
            childAspectRatio: .65),
        emptyBuilder: (ctx) => const EmptyBuilder(),
        errorBuilder: (context, retry) => ErrorBuilder(retry: retry),
        loadingBuilder: (_) => const CatalogueLoaderBuilder(count: 12),
        loadingMoreBuilder: (_) => const CatalogueLoaderBuilder(padding: true));
  }
}
