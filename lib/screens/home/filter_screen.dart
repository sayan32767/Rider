import 'package:flutter/material.dart';
import 'package:rider/utils/colors.dart';
import 'package:rider/utils/gradient_scaffold.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Select Filters'),
      ),
      body: Column(),
    );
  }
}