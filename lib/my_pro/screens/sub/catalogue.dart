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
  // static Widget get({
  //   required BuildContext context,
  // }) {
  //   return BlocProvider(
  //     create: (context) => LoadMeCatalogueCubit(context.read()),
  //     child: CatalogueView._(),
  //   );
  // }

  const CatalogueView();

  @override
  State<CatalogueView> createState() => _CatalogueViewState();
}

class _CatalogueViewState extends State<CatalogueView> {
  late final cubit = context.read<LoadMeCatalogueCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoadMeCatalogueCubit, LoadCatalogueState>(
        listenWhen: (previous, current) =>
            previous is LoadingCatalogueState &&
            current is LoadCatalogueReadyState,
        listener: (context, state) {
          // scrollController.animateTo(
          //   scrollController.position.maxScrollExtent,
          //   duration: Duration(milliseconds: 300),
          //   curve: Curves.easeInOut
          // );
        },
        child: AutoListView.get<Catalogue>(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom),
            autoManage: false,
            cubit: cubit,
            viewType: ViewType.grid,
            itemBuilder: (context, catalogue) =>
                MyCatalogueItem.get(context: context, catalogue: catalogue),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
                childAspectRatio: .65),
            emptyBuilder: (ctx) => const EmptyBuilder(),
            errorBuilder: (context, retry) => ErrorBuilder(retry: retry),
            loadingBuilder: (_) => const CatalogueLoaderBuilder(count: 12),
            loadingMoreBuilder: (_) =>
                const CatalogueLoaderBuilder(padding: true)));
  }
}
