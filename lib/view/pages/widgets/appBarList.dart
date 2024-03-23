import 'package:flutter/material.dart';

PreferredSizeWidget appBarList(String title) {
  return AppBar(
    title: Row(
      children: [
        Icon(Icons.date_range),
        SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    ),
    backgroundColor: Colors.tealAccent.shade700,
  );
}