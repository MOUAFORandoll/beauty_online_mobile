import 'package:potatoes/common/bloc/value_cubit.dart';
import 'package:video_player/video_player.dart';

class VideoCubit extends ValueCubit<VideoPlayerController?> {
  VideoCubit() : super(null);

  void stopPlaying() {
    final controller = state;
    if (controller != null && controller.value.isPlaying) {
      controller.seekTo(Duration.zero);
      controller.pause();
      set(controller);
    }
  }

  void dispose() {
    stopPlaying();
    set(null);
  }
}
