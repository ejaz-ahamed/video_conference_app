import 'package:flutter/material.dart';
import 'package:video_conference_app/utils/utils.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
   const CallPage(
      {super.key,
      required this.callID,
      required this.userName,
      required this.uid});
  final String callID;
  final String userName;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZegoUIKitPrebuiltCall(
        appID: MyConst.appId,
        appSign: MyConst.appSign,
        userID: uid,
        userName: userName,
        callID: callID,
        config: ZegoUIKitPrebuiltCallConfig.groupVideoCall(),
      ),
    );
  }
}
