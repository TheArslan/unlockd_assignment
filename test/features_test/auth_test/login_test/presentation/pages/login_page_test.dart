import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'package:unlockd_assignment/features/auth/presentation/bloc/login_bloc.dart';
import 'package:unlockd_assignment/features/auth/presentation/pages/login_page.dart';

import 'package:unlockd_assignment/core/constants/string_constants.dart';

// Mock class for LoginBloc
class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  late MockLoginBloc mockLoginBloc;

  setUp(() {
    // Initialize the mock bloc before each test
    mockLoginBloc = MockLoginBloc();
    final sl = GetIt.instance;
    sl.registerFactory<LoginBloc>(() => mockLoginBloc);
  });
  tearDown(() {
    // Unregister the bloc after the test
    GetIt.instance.reset();
  });

  group('LoginPage', () {
    testWidgets('renders LoginPage correctly', (WidgetTester tester) async {
      // Set the initial state for the mock bloc
      when(() => mockLoginBloc.state).thenReturn(LoginInitial());
      when(() => mockLoginBloc.stream)
          .thenAnswer((_) => Stream.value(LoginInitial()));

      // Build LoginPage widget inside a BlocProvider
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<LoginBloc>(
            create: (_) => mockLoginBloc,
            child: const LoginPage(),
          ),
        ),
      );

      // Verify if the widgets are displayed correctly
      expect(find.text(StringConstants.welcome), findsOneWidget);
      expect(find.text(StringConstants.enterYourCredentialsToLogin),
          findsOneWidget);
      expect(find.byKey(const ValueKey('emailTextField')), findsOneWidget);
      expect(find.byKey(const ValueKey('passwordTextField')), findsOneWidget);
      expect(find.text(StringConstants.logIn), findsOneWidget);
    });

    testWidgets('shows loading indicator when state is LoadingState',
        (WidgetTester tester) async {
      // Set the state to LoadingState
      when(() => mockLoginBloc.state).thenReturn(LoadingState());

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<LoginBloc>(
            create: (_) => mockLoginBloc,
            child: const LoginPage(),
          ),
        ),
      );

      // Trigger a frame
      await tester.pump();

      // Verify if the loading indicator is displayed
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('submits login form when button is pressed',
        (WidgetTester tester) async {
      // Set the initial state for the mock bloc
      when(() => mockLoginBloc.state).thenReturn(LoginInitial());

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<LoginBloc>(
            create: (_) => mockLoginBloc,
            child: const LoginPage(),
          ),
        ),
      );

      // Enter username and password
      await tester.enterText(
          find.byKey(const ValueKey('emailTextField')), 'testuser');
      await tester.enterText(
          find.byKey(const ValueKey('passwordTextField')), 'password123');

      // Press the login button
      await tester.tap(find.text(StringConstants.logIn));
      await tester.pump(); // Rebuild the widget after the state change

      // Verify that the OnLoginButtonPressed event was added to the bloc
      verify(() => mockLoginBloc.add(const OnLoginButtonPressed(
          username: 'testuser', password: 'password123'))).called(1);
    });
  });
}
