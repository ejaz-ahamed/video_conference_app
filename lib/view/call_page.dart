import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_conference_app/utils/utils.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallPage extends StatelessWidget {
  const VideoCallPage({Key? key, required this.callID}) : super(key: key);
  final String callID;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Stack(
        children: [
          ZegoUIKitPrebuiltCall(
            appID: MyConst.appId,
            appSign: MyConst.appSign,
            userID: user.uid,
            userName: user.displayName!,
            callID: callID,
            config: ZegoUIKitPrebuiltCallConfig.groupVideoCall(),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: callID));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('UID copied to clipboard')),
                );
              },
              child: Text(
                'UID : $callID',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}