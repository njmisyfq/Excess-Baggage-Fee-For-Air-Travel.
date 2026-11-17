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

  void _calculate() {
    if (!_validate()) {
      setState(() {
        _excessWeight = null;
        _charge = null;
        _total = null;
      });
      return;
    }

    final weight = double.parse(_weightCtrl.text.trim());
    final rate = double.parse(_rateCtrl.text.trim());
    final allowance = _ticketClass == 'Economy' ? 20.0 : 40.0;

    final excess = (weight - allowance) > 0 ? (weight - allowance) : 0.0;
    final charge = excess * rate;
    final total = charge + (0.08 * charge);

    setState(() {
      _excessWeight = excess;
      _charge = charge;
      _total = total;
    });
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
            onPressed: _calculate,
            child: const Text('Calculate', style: TextStyle(fontSize: 16)),
          ),

          if (_total != null) ...[
            const SizedBox(height: 24),
            Card(
              color: AppColors.sage,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Excess weight: ${_excessWeight!.toStringAsFixed(1)} kg',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Excess charge: RM ${_charge!.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Divider(color: AppColors.dark),
                    Text(
                      'Total payable (incl. 8% tax): RM ${_total!.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.dark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
