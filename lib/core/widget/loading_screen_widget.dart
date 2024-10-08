import 'package:flutter/material.dart';

// Custom LoadingScreenView for global use

class LoadingScreenView extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingScreenView({
    super.key,
    required this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black54,
            alignment: Alignment.center,
            child: const Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
      ],
    );
  }
}
