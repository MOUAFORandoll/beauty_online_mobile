import 'package:beauty/common/bloc/link_cubit.dart';
import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/widgets/loader_builder.dart';
import 'package:beauty/home/screens/sub/actu_screen.dart';
import 'package:beauty/my_pro/screens/sub/my_rendez_vous_pro_view.dart';
import 'package:beauty/notifications/bloc/notification_cubit.dart';
import 'package:beauty/professional/screens/client_professional_board.dart';
import 'package:beauty/professional/screens/sub/rendez_vous_user_view.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart';

class AwaitLoadScreen extends StatefulWidget {
  const AwaitLoadScreen({super.key});

  @override
  State<AwaitLoadScreen> createState() => _AwaitLoadScreenState();
}

class _AwaitLoadScreenState extends State<AwaitLoadScreen>
    with CompletableMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
        listener: (ctx, stateNotification) {
          if (stateNotification is NotificationErrorState) {
            showErrorToast(content: stateNotification.error, context: context);
            Navigator.pop(context);
          }
        },
        builder: (ctx, stateNotification) =>
            BlocConsumer<LinkCubit, LinkState>(listener: (ctx, state) {
              if (state is LinkError) {
                showErrorToast(content: state.error, context: context);

                Navigator.pop(context);
              }
            }, builder: (ctx, stateLink) {
              print(stateNotification);
              Widget? widget;
              if (stateLink is ActuLinkLoading ||
                  stateNotification is RdvNotificationLoadingState) {
                widget = PostViewLoaderBuilder();
              } else if (stateLink is ProfessionalLinkLoading) {
                widget = PersonAccountViewLoaderBuilder();
              } else if (stateLink is ActuLinkLoaded) {
                widget = ActuScreen.get(actu: stateLink.actu, context: context);
              } else if (stateLink is ProfessionalLinkLoaded) {
                widget = ClientProfessionalBoard.get(
                    professional: stateLink.professional, context: context);
              } else if (stateNotification
                  is RdvClientNotificationSuccessLoadState) {
                widget = Scaffold(
                    appBar: AppBar(
                      leading: BackButton(),
                    ),
                    body: RendezVousUserView(
                        closeButton: false,
                        rendezVous: stateNotification.rendezVous));
              } else if (stateNotification
                  is RdvProNotificationSuccessLoadState) {
                widget = Scaffold(
                    appBar: AppBar(
                      leading: BackButton(),
                    ),
                    body: MyRendezVousProView(
                        closeButton: false,
                        rendezVous: stateNotification.rendezVous));
              } else {
                widget = Scaffold(
                    appBar: AppBar(
                      leading: BackButton(),
                    ),
                    body: Container());
              }
              return widget;
            }));
  }
}
