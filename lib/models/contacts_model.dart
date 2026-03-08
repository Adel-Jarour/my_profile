import 'package:flutter/material.dart';

class ContactsModel {
  const ContactsModel({
    required this.id,
    required this.icon,
    required this.label,
  });

  final int id;
  final IconData icon;
  final String label;
}
