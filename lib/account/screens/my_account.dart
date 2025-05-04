import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
import 'package:share_plus/share_plus.dart';
import 'package:beauty/account/screens/edit_profile.dart';
import 'package:beauty/account/screens/settings/edit_profile_picture_screen.dart';
import 'package:beauty/account/screens/settings/settings_screen.dart';
import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/widgets/action_widget.dart';
import 'package:beauty/common/widgets/bottom_sheet.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/common/widgets/profile_picture.dart';
import 'package:beauty/utils/assets.dart';
import 'package:beauty/utils/dialogs.dart';
import 'package:beauty/utils/svg_utils.dart';
import 'package:beauty/utils/themes.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount>
    with SingleTickerProviderStateMixin, CompletableMixin {
  late final userCubit = context.read<UserCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
        listener: onEventReceived,
        builder: (context, state) {
          late final user = userCubit.user;

          return Column(
            children: [
              Container(),
            ],
          );
        });
  }

  void onEventReceived(BuildContext context, UserState state) async {
    await waitForDialog();

    // empêche cette page d'écouter les évenements lancés dans les pages au dessus
    if (!(ModalRoute.of(context)?.isCurrent ?? false)) return;

    if (state is UserLoggingOut) {
      loadingDialogCompleter =
          showLoadingBarrier(context: context, text: "Déconnexion…");
    } else if (state is ShareUserLoadingState) {
      loadingDialogCompleter = showLoadingBarrier(
        context: context,
      );
    } else if (state is ShareUserSuccessState) {
      await Share.share(state.shareLink);
    } else if (state is UserErrorState) {
      showErrorToast(content: state.error, context: context);
    }
  }
}
