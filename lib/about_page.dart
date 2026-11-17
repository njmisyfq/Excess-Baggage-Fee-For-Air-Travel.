import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart'; // for AppColors

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const _repoUrl =
      'https://github.com/njmisyfq/Excess-Baggage-Fee-For-Air-Travel.';

  Future<void> _openRepo(BuildContext context) async {
    final ok = await launchUrl(
      Uri.parse(_repoUrl),
      mode: LaunchMode.externalApplication,
    );
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open the link.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/icon.png', width: 100, height: 100),
            ),
            const SizedBox(height: 16),
            const Text(
              'Excess Baggage Fee Calculator',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(height: 24),
            Card(
              color: AppColors.sage,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: MUHAMMAD NAJMI SYAFIQ BIN SULEIMAN'),
                    SizedBox(height: 6),
                    Text('Matric No: 2024801024'),
                    SizedBox(height: 6),
                    Text('Course: CDCS251'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: () => _openRepo(context),
              child: const Text(
                _repoUrl,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.olive,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '© 2026 MUHAMMAD NAJMI SYAFIQ BIN SULEIMAN. All rights reserved.',
              style: TextStyle(fontSize: 12, color: AppColors.dark),
            ),
          ],
        ),
      ),
    );
  }
}
