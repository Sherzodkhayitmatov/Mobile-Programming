import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_data_model.dart';

class AsyncDataScreen extends StatelessWidget {
  const AsyncDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 3: Async Data')),
      body: Consumer<UserDataModel>(
        builder: (context, model, child) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (model.isLoading)
                    const Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text('Loading data...', style: TextStyle(fontSize: 18)),
                      ],
                    ),

                  if (model.data.isNotEmpty && !model.isLoading)
                    Column(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                          size: 60,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            model.data,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),

                  if (!model.isLoading && model.data.isEmpty)
                    const Column(
                      children: [
                        Icon(
                          Icons.cloud_download,
                          size: 60,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No data loaded yet',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),

                  const SizedBox(height: 40),

                  ElevatedButton.icon(
                    onPressed: model.isLoading
                        ? null
                        : () => model.fetchUserData(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Load Data'),
                  ),

                  if (model.data.isNotEmpty)
                    TextButton(
                      onPressed: model.isLoading
                          ? null
                          : () => model.clearData(),
                      child: const Text('Clear'),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
