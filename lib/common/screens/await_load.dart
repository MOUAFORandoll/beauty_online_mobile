import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/widgets/loader_builder.dart';
import 'package:beauty/my_pro/screens/sub/my_rendez_vous_pro_view.dart';
import 'package:beauty/notifications/bloc/notification_cubit.dart';
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
    }, builder: (ctx, stateNotification) {
      Widget? widget;
      if (stateNotification is RdvNotificationLoadingState) {
        widget = PostViewLoaderBuilder();
      } else if (stateNotification is RdvNotificationSuccessLoadState) {
        widget = Scaffold(
            appBar: AppBar(
              leading: BackButton(),
            ),
            body: RendezVousUserView(rendezVous: stateNotification.rendezVous));
      } else if (stateNotification is RdvProNotificationSuccessLoadState) {
        widget = Scaffold(
            appBar: AppBar(
              leading: BackButton(),
            ),
            body:
                MyRendezVousProView(rendezVous: stateNotification.rendezVous));
      } else {
        widget = Scaffold(
            appBar: AppBar(
              leading: BackButton(),
            ),
            body: Container());
      }
      return widget;
    });
  }
}
