import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:video_conference_app/utils/utils.dart';

class CallPage extends StatefulWidget {
  final String? channelName;
  final ClientRoleType? role;
  const CallPage({super.key, required this.channelName, required this.role});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool viewPanel = false;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    _users.clear();
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  Future<void> initialize() async {
    if (appId.isEmpty) {
      setState(() {
        _infoStrings
            .add("APP_ID is missing, plaese provide your APP_ID in utils,dart");
        _infoStrings.add("Agora engine is not starting");
      });
      return;
    }

    //! _initAgoraRtcEngine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    await _engine.enableVideo();
    await _engine
        .setChannelProfile(ChannelProfileType.channelProfileLiveBroadcasting);
    await _engine.setClientRole(role: widget.role!);

    //! _addAgoraEventHandlers
    _addAgoraEventHandlers();
    VideoEncoderConfiguration configuration = const VideoEncoderConfiguration(
      dimensions: VideoDimensions(width: 1920, height: 1080),
    );
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(
      token: token,
      channelId: widget.channelName!,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  void _addAgoraEventHandlers() {
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onError: (err, msg) {
          setState(() {
            final info = "Error : $msg";
            _infoStrings.add(info);
          });
        },
        onJoinChannelSuccess: (connection, elapsed) {
          setState(() {
            final info =
                "Join Channel : ${connection.channelId} uid : ${connection.localUid}";
            _infoStrings.add(info);
          });
        },
        onLeaveChannel: (connection, stats) {
          setState(() {
            _infoStrings.add("Leave Channel");
            _users.clear();
          });
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          setState(() {
            final info = "User Joined : $remoteUid";
            _infoStrings.add(info);
            _users.add(remoteUid);
          });
        },
        onUserOffline: (connection, remoteUid, reason) {
          setState(() {
            final info = "User Offline : $remoteUid";
            _infoStrings.add(info);
            _users.remove(remoteUid);
          });
        },
        onFirstRemoteVideoFrame:
            (connection, remoteUid, width, height, elapsed) {
          setState(() {
            final info = "First Remote Video: $remoteUid $width x $height";
            _infoStrings.add(info);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meet-Up"),
      ),
    );
  }
}
