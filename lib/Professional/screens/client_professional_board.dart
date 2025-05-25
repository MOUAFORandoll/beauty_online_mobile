import 'dart:math';

import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/widgets/action_widget.dart';
import 'package:beauty/common/widgets/bottom_sheet.dart';
import 'package:beauty/professional/bloc/professional_cubit.dart';
import 'package:beauty/common/models/professional.dart';
import 'package:beauty/professional/screens/sub/primary_info_pro_client.dart';
import 'package:beauty/professional/screens/sub/stories.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/services/professional_cubit_manager.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';

import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:share_plus/share_plus.dart';

import '../../professional/screens/sub/catalogue_pro.dart';

class ClientProfessionalBoard extends StatefulWidget {
  static Widget get({
    required BuildContext context,
    required Professional professional,
  }) {
    return BlocProvider.value(
      value: context.read<ProfessionalCubitManager>().get(professional),
      child: ClientProfessionalBoard._(),
    );
  }

  const ClientProfessionalBoard._();
  @override
  State<ClientProfessionalBoard> createState() =>
      _ClientProfessionalBoardState();
}

class _ClientProfessionalBoardState extends State<ClientProfessionalBoard>
    with SingleTickerProviderStateMixin, CompletableMixin {
  late TabController _tabController;
  @override
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    _tabController.addListener(() {
      print(
          '_tabController.indexIsChanging    ===${_tabController.indexIsChanging}');
      if (_tabController.indexIsChanging == false) {
        print('_tabController.index    ===${_tabController.index}');
        setState(() {}); // Rafraîchit la FAB quand l'index change

        print('_tabController.index    ===${_tabController.index}');
      }
    });
  }

  late final professionalCubit = context.read<ProfessionalCubit>();
  late final ScrollController _scrollController = ScrollController();

  void onEventReceived(BuildContext context, ProfessionalState state) async {
    await waitForDialog();

    if (state is ShareProfessionalLoadingState) {
      loadingDialogCompleter = showLoadingBarrier(
        context: context,
      );
    } else if (state is ShareProfessionalSuccessState) {
      await Share.share(state.link);
    } else if (state is ProfessionalErrorState) {
      showErrorToast(content: state.error, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {},
        child: BlocConsumer<ProfessionalCubit, ProfessionalState>(
            listener: onEventReceived,
            builder: (context, state) {
              return NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (context, _) => [
                        SliverAppBar(
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          foregroundColor: AppTheme.white,
                          expandedHeight: 250,
                          pinned: true,
                          actions: [
                            IconButton(
                              onPressed: onActionsPressed,
                              icon: toSvgIcon(
                                icon: Assets.iconsOptions,
                                color: AppTheme.white,
                              ),
                            ),
                          ],
                          flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image(
                                    fit: BoxFit.cover,
                                    image: context
                                        .read<AppCacheManager>()
                                        .getImage(professionalCubit
                                                .professional.cover ??
                                            ''),
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container()

                                    // errorBuilder: (context, error, stackTrace) =>
                                    //     Icon(
                                    //   Icons.error,
                                    //   color: Theme.of(context)
                                    //       .colorScheme
                                    //       .onTertiaryContainer,
                                    //   size: 32,
                                    // ),
                                    ),

                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).viewPadding.top *
                                                2.5 +
                                            kToolbarHeight,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Theme.of(context)
                                              .colorScheme
                                              .inverseSurface,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                      child: Column(children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 24,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  professionalCubit.professional
                                                          .namePro ??
                                                      '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge!
                                                      .copyWith(
                                                          fontSize: 30,
                                                          color: Colors.white),
                                                ),
                                                const SizedBox(height: 4),
                                              ],
                                            )
                                          ],
                                        ),
                                      ])),
                                ),
                                // Positioned(
                                //     top: 8, left: 0, right: 8, child: toSvgIcon(Asser)),
                              ],
                            ),
                          ),
                          systemOverlayStyle: Theme.of(context)
                              .appBarTheme
                              .systemOverlayStyle
                              ?.copyWith(
                                  statusBarIconBrightness: Brightness.light),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            color: AppTheme.white,
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 16.0, right: 16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const PrimaryInfoProClient(),
                                ]),
                          ),
                        ),
                      ],
                  body: Material(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Scaffold(
                              primary: false,
                              body: Material(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: Stack(children: [
                                  Column(children: [
                                    _TabBarGap(controller: _scrollController),
                                    TabBar(
                                      isScrollable: false,
                                      controller: _tabController,
                                      tabAlignment: TabAlignment.fill,
                                      splashBorderRadius:
                                          BorderRadius.circular(64.0),
                                      tabs: const [
                                        Tab(text: "Catalogues"),
                                        // Tab(text: "Stories"),
                                        // Tab(text: "Reservations"),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Expanded(
                                      child: TabBarView(
                                        controller: _tabController,
                                        children: [
                                          CatalogueProView.get(
                                              context: context,
                                              professional: professionalCubit
                                                  .professional),
                                          // Stories(),
                                          // Stories(),
                                        ],
                                      ),
                                    )
                                  ]),
                                ]),
                              )))));
            }));
  }

  void onActionsPressed() => showAppBottomSheet(
      context: context,
      builder: (innerContext) => Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ActionWidget(
                  title: 'Partager…',
                  icon: Assets.iconsShare,
                  onTap: () {
                    professionalCubit.shareProfile();
                    Navigator.of(innerContext).pop();
                  },
                ),
              ],
            ),
          ));

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _TabBarGap extends StatefulWidget {
  final ScrollController controller;

  const _TabBarGap({required this.controller});

  @override
  State<_TabBarGap> createState() => _TabBarGapState();
}

class _TabBarGapState extends State<_TabBarGap> {
  double gap = 0.0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (!widget.controller.hasClients) return;

      // calcule la distance entre le début du body (du NestedScrollView) et
      // le haut de l'écran, et en fait un SizedBox. L'écart s'adapte en
      // fonction de la distance entre les deux, ce qui donne l'effet sticky.
      setState(() {
        gap = max(
            widget.controller.position.pixels -
                (widget.controller.position.maxScrollExtent -
                    MediaQuery.of(context).viewPadding.top -
                    kToolbarHeight),
            0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: gap);
  }
}
