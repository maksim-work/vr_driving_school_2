import 'package:flutter/material.dart';
import 'package:vr_player/vr_player.dart';


class LessonPage extends StatefulWidget {
  const LessonPage({Key? key}) : super(key: key);

  @override
  State<LessonPage> createState() => _LessonPageState();
}


class _LessonPageState extends State<LessonPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: VrPlayer(
          x: 0,
          y: 0,
          onCreated: onViewPlayerCreated,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
  // void onViewPlayerCreated(VrPlayerController controller, VrPlayerObserver observer) {
  //   this.viewPlayerController = controller;
  //   observer.handleStateChange(this.onReceiveState);
  //   observer.handleDurationChange(this.onReceiveDuration);
  //   observer.handlePositionChange(this.onChangePosition);
  //   observer.handleFinishedChange(this.onReceiveEnded);
  //   this._viewPlayerController.loadVideo(
  //     videoUrl: "https://letsdeal.ae/wp-content/uploads/2023/01/testRoom1_1920Mono.mp4",
  //   );
  // }

  void onViewPlayerCreated(VrPlayerController controller, VrPlayerObserver observer) {
    observer.handleStateChange(this.onReceiveState);
    observer.handleDurationChange(this.onReceiveDuration);
    observer.handlePositionChange(this.onChangePosition);
    observer.handleFinishedChange(this.onReceiveEnded);
    this.controller.loadVideo(
      videoUrl: "https://letsdeal.ae/wp-content/uploads/2023/01/testRoom1_1920Mono.mp4",
    );
  }


}


