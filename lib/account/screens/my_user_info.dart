import 'package:beauty/account/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
import 'package:share_plus/share_plus.dart';
import 'package:beauty/account/screens/settings/edit_user.dart';

import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/widgets/bottom_sheet.dart';
import 'package:beauty/common/utils/dialogs.dart';

class MyUserInfo extends StatefulWidget {
  const MyUserInfo({super.key});

  @override
  State<MyUserInfo> createState() => _MyUserInfoState();
}

class _MyUserInfoState extends State<MyUserInfo>
    with SingleTickerProviderStateMixin, CompletableMixin {
  late final userCubit = context.read<UserCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
        listener: onEventReceived,
        buildWhen: (context, state) => state is UserLoggedState,
        builder: (context, state) {
          late final user = userCubit.user;

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Profil',
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),

                        ProfileCardScreen(),
                        const SizedBox(height: 30),

                        // Name section
                        GestureDetector(
                          onTap: () => showAppBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (innerContext) =>
                                  EditUserScreen(type: 0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Nom',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade900,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      userCubit.user.userName!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(Icons.chevron_right,
                                        color: Colors.grey),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Phone number section
                        GestureDetector(
                          onTap: () => showAppBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (innerContext) =>
                                  EditUserScreen(type: 1)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Numéro de téléphone',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade900,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${userCubit.user.codePhone!} ${userCubit.user.phone!}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(Icons.chevron_right,
                                        color: Colors.grey),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Links section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Liens',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Ajouter des liens',
                                    style: TextStyle(
                                      color: Color(0xFF4CAF50),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Icon(Icons.chevron_right, color: Colors.grey),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
