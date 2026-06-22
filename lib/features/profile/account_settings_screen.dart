import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/electro_text_field.dart';
import '../../shared/widgets/electro_button.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.containerMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Personal Information', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 24),
            const ElectroTextField(
              hintText: 'Full Name',
              prefixIcon: Icon(Icons.person_outline),
            ),
            const SizedBox(height: 16),
            const ElectroTextField(
              hintText: 'Email Address',
              prefixIcon: Icon(Icons.email_outlined),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            const ElectroTextField(
              hintText: 'Phone Number',
              prefixIcon: Icon(Icons.phone_outlined),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 32),
            Text('Security', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 24),
            const ElectroTextField(
              hintText: 'Current Password',
              prefixIcon: Icon(Icons.lock_outline),
              isPassword: true,
            ),
            const SizedBox(height: 16),
            const ElectroTextField(
              hintText: 'New Password',
              prefixIcon: Icon(Icons.lock_outline),
              isPassword: true,
            ),
            const SizedBox(height: 48),
            ElectroButton(
              text: 'Save Changes',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
