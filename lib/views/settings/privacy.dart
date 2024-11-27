import 'package:flutter/material.dart';

class PrivacySettings extends StatefulWidget {
  const PrivacySettings({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PrivacySettingsState createState() => _PrivacySettingsState();
}

class _PrivacySettingsState extends State<PrivacySettings> {
  bool _shareListeningActivity = false;
  bool _shareUsageData = false;
  bool _personalizedAds = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Share Listening Activity'),
            value: _shareListeningActivity,
            onChanged: (bool value) {
              setState(() {
                _shareListeningActivity = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Share Usage Data'),
            value: _shareUsageData,
            onChanged: (bool value) {
              setState(() {
                _shareUsageData = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Personalized Ads'),
            value: _personalizedAds,
            onChanged: (bool value) {
              setState(() {
                _personalizedAds = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
