import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_conference_app/view/call_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final _channelController = TextEditingController();
  bool _validateError = false;
  ClientRoleType? _role = ClientRoleType.clientRoleBroadcaster;

  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Meet-Up"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Image.asset("assets/images/onboarding.jpg"),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _channelController,
                  decoration: InputDecoration(
                    hintText: 'Channel Name',
                    errorText:
                        _validateError ? "Channel name is mandatory" : null,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                    ),
                  ),
                ),
                RadioListTile(
                  title: const Text("Create"),
                  value: ClientRoleType.clientRoleBroadcaster,
                  groupValue: _role,
                  onChanged: (value) {
                    setState(() {
                      _role = value;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text("Join"),
                  value: ClientRoleType.clientRoleAudience,
                  groupValue: _role,
                  onChanged: (value) {
                    setState(() {
                      _role = value;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: _join,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50)),
                  child: Text(
                    _role == ClientRoleType.clientRoleBroadcaster
                        ? 'Create'
                        : "Join",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _join() async {
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      await Future.sync(() => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CallPage(channelName: _channelController.text, role: _role),
            ),
          ));
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    log(status.toString());
  }
}
