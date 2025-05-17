import 'package:beauty/common/models/rendez_vous.dart';
import 'package:beauty/common/widgets/empty_builder.dart';
import 'package:beauty/common/widgets/error_builder.dart';
import 'package:beauty/common/widgets/filter_buttons.dart';
import 'package:beauty/common/widgets/horizontal_service_list.dart';
import 'package:beauty/common/widgets/location_selector.dart';
import 'package:beauty/common/widgets/post_list.dart';
import 'package:beauty/common/widgets/salon_card_list.dart';
import 'package:beauty/common/widgets/search_bar.dart';
import 'package:beauty/common/widgets/section_title.dart';
import 'package:beauty/my_pro/bloc/load_me_pro_rendez_vous_cubit.dart';
import 'package:beauty/my_pro/widgets/my_item_rendez_vous_pro.dart';
import 'package:beauty/notifications/bloc/load_notifications_cubit.dart';
import 'package:beauty/notifications/services/notifications_service.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:flutter/material.dart' hide SearchBar, Notification;
import 'package:potatoes/auto_list/models/paginated_list.dart';
import 'package:potatoes/auto_list/widgets/auto_list_view.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/notifications/models/notification.dart';

class RendezVousPro extends StatefulWidget {
  const RendezVousPro({super.key});

  @override
  State<RendezVousPro> createState() => _RendezVousProState();
}

class _RendezVousProState extends State<RendezVousPro> {
  late final loadMeProRendezVousCubit =
      context.read<LoadMeProRendezVousCubit>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          loadMeProRendezVousCubit.reset();
        },
        child: AutoListView.get<RendezVous>(
          autoManage: false,
          cubit: loadMeProRendezVousCubit,
          shrinkWrap: true,
          emptyBuilder: (context) => EmptyBuilder(),
          itemBuilder: (context, rendezVous) =>
              MyItemRendezVousPro(rendezVous: rendezVous),
          errorBuilder: (context, retry) => ErrorBuilder(retry: retry),
        ));
  }
}
