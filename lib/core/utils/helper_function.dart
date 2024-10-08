import 'package:flutter/material.dart';

// Global function to hide keyboard
void hideKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
