import 'package:beauty/Professional/bloc/professional_cubit.dart';
import 'package:beauty/account/bloc/cubit/account_view_manage_cubit.dart';
import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/common/widgets/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/utils/assets.dart';
import 'package:beauty/utils/svg_utils.dart';
import 'package:beauty/utils/themes.dart';

class BtnAccount extends StatefulWidget {
  @override
  State<BtnAccount> createState() => _BtnAccountState();
}

class _BtnAccountState extends State<BtnAccount> {
  late final userCubit = context.read<UserCubit>();
  late final professionalCubit = context.read<ProfessionalCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      late final user = userCubit.user;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Column(children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {},
                          child: const UserProfilePicture(
                            size: 80,
                            isSquare: true,
                          )),
                      SizedBox(
                        width: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.userName ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.phone ?? '',
                            maxLines: 100,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                ])),
            BlocBuilder<AccountViewManageCubit, bool>(
              builder: (ctx, state) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: BeautyButton.transparent(
                      onPressed: () => context
                          .read<AccountViewManageCubit>()
                          .changeView(true),
                      isSelected: state == true,
                      text: "Mon Compte",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: BeautyButton.transparent(
                      onPressed: () => context
                          .read<AccountViewManageCubit>()
                          .changeView(false),
                      isSelected: state == false,
                      text: "Professionnel",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
