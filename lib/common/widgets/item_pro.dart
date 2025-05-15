import 'package:beauty/professional/bloc/professional_cubit.dart';
import 'package:beauty/common/models/professional.dart';
import 'package:beauty/professional/screens/client_professional_board.dart';
import 'package:beauty/common/services/professional_cubit_manager.dart';
import 'package:beauty/common/widgets/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';

class ProfessionalItem extends StatelessWidget {
  static Widget get({
    required BuildContext context,
    required Professional professional,
  }) {
    return BlocProvider.value(
      value: context.read<ProfessionalCubitManager>().get(professional),
      child: ProfessionalItem._(),
    );
  }

  const ProfessionalItem._();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfessionalCubit, ProfessionalState>(
      builder: (context, state) {
        final professionalCubit = context.read<ProfessionalCubit>();

        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ClientProfessionalBoard.get(
                  context: context,
                  professional: professionalCubit.professional))),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: ProfilePicture(
              image: professionalCubit.professional.cover,
              size: 64.0,
            ),
            title: Text(professionalCubit.professional.namePro,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge),
            subtitle: Text(
                '${professionalCubit.professional.nombreActes} ${professionalCubit.professional.nombreActes > 1 ? 'realisations' : 'realisation'}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium),
            // trailing: const BtnActionItemProfessional(),
            dense: true,
          ),
        );
      },
    );
  }
}
