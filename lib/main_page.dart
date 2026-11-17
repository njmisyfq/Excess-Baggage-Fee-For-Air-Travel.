import 'package:flutter/material.dart';

import 'main.dart'; // for AppColors

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _weightCtrl = TextEditingController();
  final _rateCtrl = TextEditingController();
  String _ticketClass = 'Economy';

  String? _weightError, _rateError;
  double? _excessWeight, _charge, _total;

  @override
  void dispose() {
    _weightCtrl.dispose();
    _rateCtrl.dispose();
    super.dispose();
  }

  // Returns true if both inputs are valid; otherwise sets error messages.
  bool _validate() {
    final weightText = _weightCtrl.text.trim();
    final rateText = _rateCtrl.text.trim();
    final weight = double.tryParse(weightText);
    final rate = double.tryParse(rateText);

    String? weightError;
    String? rateError;

    if (weightText.isEmpty) {
      weightError = 'Please enter the baggage weight.';
    } else if (weight == null || !weight.isFinite) {
      weightError = 'Weight must be a valid number.';
    } else if (weight < 0) {
      weightError = 'Weight cannot be negative.';
    }

    if (rateText.isEmpty) {
      rateError = 'Please enter the rate per kg.';
    } else if (rate == null || !rate.isFinite) {
      rateError = 'Rate must be a valid number.';
    } else if (rate < 0) {
      rateError = 'Rate cannot be negative.';
    }

    setState(() {
      _weightError = weightError;
      _rateError = rateError;
    });

    return weightError == null && rateError == null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.sage.withOpacity(0.35),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: AppColors.dark),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Enter your baggage weight, ticket class and the rate per kg to calculate excess baggage fees.',
                    style: TextStyle(color: AppColors.dark, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _weightCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Checked baggage weight (kg)',
              prefixIcon: const Icon(Icons.luggage),
              border: const OutlineInputBorder(),
              errorText: _weightError,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.dark.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.airplane_ticket, color: AppColors.dark),
                    SizedBox(width: 8),
                    Text(
                      'Ticket class',
                      style: TextStyle(
                        color: AppColors.dark,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                RadioListTile<String>(
                  title: const Text('Economy (20 kg)'),
                  value: 'Economy',
                  groupValue: _ticketClass,
                  activeColor: AppColors.olive,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  onChanged: (v) => setState(() => _ticketClass = v!),
                ),
                RadioListTile<String>(
                  title: const Text('Business (40 kg)'),
                  value: 'Business',
                  groupValue: _ticketClass,
                  activeColor: AppColors.olive,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  onChanged: (v) => setState(() => _ticketClass = v!),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _rateCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Excess baggage rate per kg (RM)',
              prefixIcon: const Icon(Icons.payments),
              border: const OutlineInputBorder(),
              errorText: _rateError,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.olive,
              foregroundColor: AppColors.cream,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: _validate,
            child: const Text('Calculate', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
