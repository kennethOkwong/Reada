import 'package:flutter/material.dart';

enum ProfileType {
  bookstore(
    label: "Bookstore",
    icon: Icons.store,
    value: "bookstore",
    enabled: true,
  ),
  author(
    label: "Author",
    icon: Icons.edit,
    value: "author",
    enabled: true,
  ),
  affiliate(
    label: "Affiliate",
    icon: Icons.people,
    value: "affiliate",
    enabled: false,
  );

  final String label;
  final IconData icon;
  final String value;
  final bool enabled;
  const ProfileType({
    required this.label,
    required this.icon,
    required this.value,
    required this.enabled,
  });
}
