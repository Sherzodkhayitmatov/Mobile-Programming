import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/settings_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 4: Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<SettingsModel>().resetToDefaults();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings reset to defaults')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Consumer<SettingsModel>(
            builder: (context, settings, child) {
              return SwitchListTile(
                title: const Text('Enable Notifications'),
                subtitle: Text(
                  settings.notificationsEnabled
                      ? 'You will receive notifications'
                      : 'Notifications are disabled',
                ),
                value: settings.notificationsEnabled,
                onChanged: settings.toggleNotifications,
                secondary: Icon(
                  settings.notificationsEnabled
                      ? Icons.notifications_active
                      : Icons.notifications_off,
                ),
              );
            },
          ),
          const Divider(),
          Consumer<SettingsModel>(
            builder: (context, settings, child) {
              return Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.volume_up),
                    title: const Text('Volume Level'),
                    subtitle: Text('${settings.volumeLevel.round()}%'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Slider(
                      value: settings.volumeLevel,
                      min: 0,
                      max: 100,
                      divisions: 20,
                      label: settings.volumeLevel.round().toString(),
                      onChanged: settings.setVolumeLevel,
                    ),
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<SettingsModel>(
              builder: (context, settings, child) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Summary',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Notifications: ${settings.notificationsEnabled ? "ON" : "OFF"}',
                        ),
                        Text('Volume: ${settings.volumeLevel.round()}%'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
