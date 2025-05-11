import 'package:beauty/Professional/bloc/professional_cubit.dart';
import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/common/utils/month_to_string.dart';
import 'package:beauty/common/utils/themes.dart';

class PrimaryInfo extends StatefulWidget {
  const PrimaryInfo({super.key});

  @override
  State<PrimaryInfo> createState() => _PrimaryInfoState();
}

class _PrimaryInfoState extends State<PrimaryInfo>
    with SingleTickerProviderStateMixin {
  late final userCubit = context.read<UserCubit>();
  late final professionalCubit = context.read<ProfessionalCubit>();

  final isCollapsed = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 8, runSpacing: 2, children: [
      Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          decoration: BoxDecoration(
            // color: AppTheme.primaryYellow,
            border: Border.all(color: AppTheme.disabledText, width: .4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on,
                color: AppTheme.disabledText,
                size: 18,
                // color: Colors.white,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                professionalCubit.professional.position.titleEmplacement,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    // color: AppTheme.onHighGreen,
                    ),
              ),
            ],
          )),
      Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          decoration: BoxDecoration(
            // color: AppTheme.primaryYellow,
            border: Border.all(color: AppTheme.disabledText, width: .4),

            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(
              Icons.timelapse_sharp,
              color: AppTheme.errorRed,
              size: 18,
              // color: Colors.white,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              "${professionalCubit.professional.nombreReservation} Reservations",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ])),
      Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          decoration: BoxDecoration(
            // color: AppTheme.primaryYellow,
            border: Border.all(color: AppTheme.disabledText, width: .4),

            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(
              Icons.check_circle,
              color: AppTheme.green,
              size: 18,
              // color: Colors.white,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              "${professionalCubit.professional.nombreCatalogue} Catalogues",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            )
          ]))
    ]);
  }
}
