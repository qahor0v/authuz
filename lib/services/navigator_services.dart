import 'package:flutter/material.dart';

void navigateID(String id, context) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    id,
        (Route<dynamic> route) => false,
  );
}