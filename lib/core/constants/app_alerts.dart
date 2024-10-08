import 'package:flutter/material.dart';
import 'package:unlockd_assignment/core/constants/string_constants.dart';

// Global key to show alerts in app
final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

// Different types of AppAlerts used Globally
class AppAlerts {
  // Error snackbar
  static void showErrorSnackBar([String? message]) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snackbarKey.currentState?.hideCurrentSnackBar();
      snackbarKey.currentState?.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 800),
          padding: const EdgeInsets.symmetric(vertical: 20),
          content: Center(
            heightFactor: 0,
            child: Text(
              message ?? StringConstants.somethingIsWrong,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.grey.shade900,
        ),
      );
    });
  }
}
