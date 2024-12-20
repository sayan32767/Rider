import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
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
        leading: IconButton(
          icon: Icon(MingCute.left_line, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        leadingWidth: 35,
        titleSpacing: 10,
        backgroundColor: AppColors.primary,
        title: Text('Select Filters'),
      ),
      body: Column(),
    );
  }
}