import 'dart:math';

import 'package:flutter/material.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ActivityLoaderBuilder extends StatelessWidget {
  final int count;

  const ActivityLoaderBuilder({super.key, this.count = 8});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, i) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.tertiaryContainer,
                radius: 12,
              ),
              const SizedBox(width: 4.0),
              CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.tertiaryContainer,
                radius: 12,
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Container(
                  height: 16,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 16,
            width: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(4),
            ),
          )
        ],
      ),
      separatorBuilder: (_, i) => const SizedBox(height: 16.0),
      itemCount: count,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}

class AgendaLoaderBuilder extends StatelessWidget {
  final int count;

  const AgendaLoaderBuilder({super.key, this.count = 8});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, i) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.tertiaryContainer,
                radius: 16,
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Container(
                  height: 16,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(4),
            ),
          )
        ],
      ),
      separatorBuilder: (_, i) => const SizedBox(height: 16.0),
      itemCount: count,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}

class CatalogueLoaderBuilder extends StatelessWidget {
  final int count;
  final bool padding;

  const CatalogueLoaderBuilder(
      {super.key, this.count = 6, this.padding = false});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding ? EdgeInsets.only(top: 2.0) : EdgeInsets.zero,
      physics: const PageScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
          childAspectRatio: .65),
      itemBuilder: (_, __) => Container(
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.tertiaryContainer,
        child: SizedBox(
          height: 16.0,
          width: 16.0,
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.onTertiaryContainer,
            strokeWidth: 2.0,
          ),
        ),
      ),
      itemCount: count, // Nombre de carrés souhaité
    );
  }
}

class ActuLoaderBuilder extends StatelessWidget {
  final int count;
  final bool padding;

  ActuLoaderBuilder({super.key, this.count = 6, this.padding = false});
  final List<Color> colors = List.generate(30, (_) => getRandomColor());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: MasonryGridView.count(
          crossAxisCount: 2, // 📌 Deux colonnes
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemCount: colors.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              height: 150 + Random().nextInt(250).toDouble(),
              child: SizedBox(
                height: 16.0,
                width: 16.0,
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                  strokeWidth: 2.0,
                ),
              ),
            );
          },
        ));
  }
}

Color getRandomColor() {
  final random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(200),
    random.nextInt(200),
    random.nextInt(200),
  );
}

class QuizLoaderBuilder extends StatelessWidget {
  final int count;

  const QuizLoaderBuilder({super.key, this.count = 3});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 72,
                  height: 88,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
      itemCount: count, // Nombre d'éléments souhaité
    );
  }
}

class StoriesLoaderBuilder extends StatelessWidget {
  final int count;

  const StoriesLoaderBuilder({super.key, this.count = 8});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, i) => Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          shape: BoxShape.circle,
        ),
      ),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, i) => const SizedBox(width: 8.0),
      itemCount: count,
      padding: EdgeInsets.symmetric(horizontal: 8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}

class PostViewLoaderBuilder extends StatelessWidget {
  const PostViewLoaderBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                      radius: 16,
                    ),
                    const SizedBox(width: 8.0),
                    Flexible(
                      child: Container(
                        height: 16,
                        width: 120,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                )
              ],
            )));
  }
}

class PersonAccountViewLoaderBuilder extends StatelessWidget {
  const PersonAccountViewLoaderBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const SizedBox(width: 4.0),
                    CircleAvatar(
                      backgroundColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                      radius: 40,
                    ),
                    const SizedBox(width: 8.0),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 16,
                            width: 152,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Container(
                            height: 56,
                            width: 232,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ]),
                  ],
                ),
                const SizedBox(height: 24.0),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 40, right: 40),
                    height: 56,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    height: 56,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(100),
                          right: Radius.circular(100)),
                    ),
                  ),
                )
              ],
            )));
  }
}

class EpisodeViewLoaderBuilder extends StatelessWidget {
  const EpisodeViewLoaderBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
        ),
        body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 8),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 88,
                        width: 72,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 24,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              height: 24,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ])));
  }
}

class CatalogueViewLoaderBuilder extends StatelessWidget {
  const CatalogueViewLoaderBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, _) => [
                  SliverAppBar(
                    backgroundColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
                    foregroundColor: AppTheme.white,
                    expandedHeight: 300,
                    pinned: true,
                    leading: BackButton(
                      color: AppTheme.white,
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: MediaQuery.of(context).viewPadding.top +
                                  kToolbarHeight,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Theme.of(context)
                                        .colorScheme
                                        .inverseSurface,
                                    Colors.transparent
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    systemOverlayStyle: Theme.of(context)
                        .appBarTheme
                        .systemOverlayStyle
                        ?.copyWith(statusBarIconBrightness: Brightness.light),
                  )
                ],
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0)
                    .copyWith(top: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 32,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(4),
                          )),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            radius: 8,
                          ),
                          const SizedBox(width: 8.0),
                          Container(
                              height: 16,
                              width: 72,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(32),
                                    left: Radius.circular(32)),
                              )),
                          const SizedBox(width: 8.0),
                          Container(
                              height: 16,
                              width: 72,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(32),
                                    left: Radius.circular(32)),
                              )),
                          const SizedBox(width: 8.0),
                          Container(
                              height: 16,
                              width: 72,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(32),
                                    left: Radius.circular(32)),
                              ))
                        ],
                      ),
                      const SizedBox(height: 32.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: Container(
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(32),
                                        left: Radius.circular(32)),
                                  ))),
                          const SizedBox(width: 8.0),
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            radius: 16,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                          height: 16,
                          width: 64,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(32),
                                left: Radius.circular(32)),
                          )),
                      const SizedBox(height: 8.0),
                      Container(
                        height: 88,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      )
                    ]))));
  }
}

class QuizViewLoaderBuilder extends StatelessWidget {
  const QuizViewLoaderBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, _) => [
                  SliverAppBar(
                    backgroundColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
                    foregroundColor: AppTheme.white,
                    expandedHeight: 300,
                    pinned: true,
                    leading: BackButton(
                      color: AppTheme.white,
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: MediaQuery.of(context).viewPadding.top +
                                  kToolbarHeight,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Theme.of(context)
                                        .colorScheme
                                        .inverseSurface,
                                    Colors.transparent
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    systemOverlayStyle: Theme.of(context)
                        .appBarTheme
                        .systemOverlayStyle
                        ?.copyWith(statusBarIconBrightness: Brightness.light),
                  )
                ],
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0)
                    .copyWith(top: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 32,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(4),
                          )),
                      const SizedBox(height: 8.0),
                      Container(
                        height: 88,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        height: 16,
                        width: 96,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        width: 260,
                        height: 16,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        height: 16,
                        width: 200,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ]))));
  }
}

class ProfessionalBoardLoaderBuilder extends StatelessWidget {
  final int count;

  const ProfessionalBoardLoaderBuilder({super.key, this.count = 8});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, i) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.tertiaryContainer,
                radius: 16,
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Container(
                  height: 16,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(4),
            ),
          )
        ],
      ),
      separatorBuilder: (_, i) => const SizedBox(height: 16.0),
      itemCount: count,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}


 