import 'package:flutter/material.dart';

import 'package:unlockd_assignment/config/theme/theme.dart';
import 'package:unlockd_assignment/core/constants/app_alerts.dart';
import 'package:unlockd_assignment/core/storages/secure_storage.dart';

import 'package:unlockd_assignment/features/auth/presentation/pages/login_page.dart';
import 'package:unlockd_assignment/features/blog_posts/presentation/pages/blog_post_page.dart';
import 'package:unlockd_assignment/injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // initalize dependency injection
  setUpLocator();
  runApp(const MyApp());
}

// function to check is User is Logged in and pass the widget accordingly
Future<Widget> checkAuth(BuildContext context) async {
  final isLggedIn = await locator<SecureStorage>().checkLogin();

  return isLggedIn ? const BlogPostPage() : const LoginPage();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: snackbarKey,
      title: 'Unlockd Assignment',
      theme: theme(),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<Widget>(
        future: checkAuth(context),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            // When the future completes, display the resulting widget
            return Center(child: snapshot.data);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
