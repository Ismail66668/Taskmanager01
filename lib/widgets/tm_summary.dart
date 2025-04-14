import 'package:flutter/material.dart';

// ignore: camel_case_types
class sumaryCard extends StatelessWidget {
  const sumaryCard({
    super.key,
    required this.title,
    required this.count,
  });
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$count",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}
