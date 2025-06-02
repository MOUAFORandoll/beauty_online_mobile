import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/models/professional.dart';
import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:beauty/professional/bloc/load_pro_catalogue_cubit.dart'; 
import 'package:beauty/professional/widgets/item_catalogue.dart';
import 'package:beauty/common/widgets/empty_builder.dart';
import 'package:beauty/common/widgets/error_builder.dart';
import 'package:beauty/common/widgets/loader_builder.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/auto_list.dart';
import 'package:potatoes/libs.dart';

class CatalogueProView extends StatefulWidget {
  static Widget get({
    required BuildContext context,
    required Professional professional,
  }) {
    return BlocProvider(
      create: (context) => LoadProCatalogueCubit(
          context.read<ProfessionalService>(), professional.id),
      child: CatalogueProView._(),
    );
  }

  const CatalogueProView._();
  @override
  State<CatalogueProView> createState() => _CatalogueProViewState();
}

class _CatalogueProViewState extends State<CatalogueProView> {
  late final cubit = context.read<LoadProCatalogueCubit>();

  @override
  Widget build(BuildContext context) {
    return AutoListView.get<Catalogue>(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
        autoManage: false,
        cubit: cubit,
        viewType: ViewType.grid,
        itemBuilder: (context, catalogue) => CatalogueItem(catalogue),
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
