import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final photoController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser!;
    nameController.text = user.displayName ?? '';
    photoController.text = user.photoURL ?? '';
  }

  Future<void> updateProfile() async {
    setState(() => loading = true);
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.updateDisplayName(nameController.text.trim());
      await user.updatePhotoURL(photoController.text.trim());
      await user.reload();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Display Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: photoController,
              decoration: const InputDecoration(labelText: 'Photo URL'),
            ),
            const SizedBox(height: 20),
            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: updateProfile,
                    child: const Text('Save Changes'),
                  ),
          ],
        ),
      ),
    );
  }
}
