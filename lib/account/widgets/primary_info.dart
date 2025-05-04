import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/utils/month_to_string.dart';
import 'package:beauty/utils/themes.dart';

class PrimaryInfo extends StatefulWidget {
  const PrimaryInfo({super.key});

  @override
  State<PrimaryInfo> createState() => _PrimaryInfoState();
}

class _PrimaryInfoState extends State<PrimaryInfo>
    with SingleTickerProviderStateMixin {
  late final userCubit = context.read<UserCubit>();

  final isCollapsed = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 8, runSpacing: 2, children: [
      Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          decoration: BoxDecoration(
            color: AppTheme.green,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            "xxxxxx",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppTheme.onHighGreen,
                ),
          )),
      Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            "xxxxx",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          )),
      Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            "xxxx",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ))
    ]);
  }
}
 