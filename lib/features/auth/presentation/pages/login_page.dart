import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unlockd_assignment/core/constants/app_alerts.dart';
import 'package:unlockd_assignment/core/constants/string_constants.dart';
import 'package:unlockd_assignment/core/utils/app_form_fields_validator.dart';
import 'package:unlockd_assignment/core/utils/extension.dart';
import 'package:unlockd_assignment/core/utils/helper_function.dart';
import 'package:unlockd_assignment/core/widget/loading_screen_widget.dart';
import 'package:unlockd_assignment/features/auth/presentation/bloc/login_bloc.dart';
import 'package:unlockd_assignment/features/blog_posts/presentation/pages/blog_post_page.dart';
import 'package:unlockd_assignment/injection_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailTextFieldController =
      TextEditingController(text: kDebugMode ? "string" : null);
  final TextEditingController passwordTextFieldController =
      TextEditingController(text: kDebugMode ? "1111" : null);
  // variable to handle password hiding
  bool _obscureText = false;

//validate form and perform login
  void loginButtonPressed(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      hideKeyBoard();
      context.read<LoginBloc>().add(OnLoginButtonPressed(
            username: emailTextFieldController.text,
            password: passwordTextFieldController.text,
          ));
    }
  }

  // If Authenicate successfully will move to Blog screen
  void _openBlogPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BlogPostPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<LoginBloc>(),
      child: Scaffold(
        body: GestureDetector(
          onTap: hideKeyBoard,
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailed) {
                AppAlerts.showErrorSnackBar(state.message);
              } else if (state is LoginSuccess) {
                _openBlogPage(context);
              }
            },
            builder: (context, state) {
              return LoadingScreenView(
                // show CircularProgressIndicator is state  is  loading
                isLoading: state is LoadingState,
                child: Center(
                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: (context.width * .07)),
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  StringConstants.welcome,
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                (context.height / 60).height,
                                Text(
                                  StringConstants.enterYourCredentialsToLogin,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                (context.height / 60).height,
                                TextFormField(
                                  key: const ValueKey('emailTextField'),
                                  controller: emailTextFieldController,
                                  decoration: const InputDecoration(
                                    hintText: StringConstants.username,
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (value) =>
                                      AppFormFieldValidator.emptyFieldValidator(
                                    value,
                                    StringConstants.pleaseEnterUsername,
                                  ),
                                ),
                                (context.height / 45).height,
                                TextFormField(
                                  key: const ValueKey('passwordTextField'),
                                  controller: passwordTextFieldController,
                                  decoration: InputDecoration(
                                    hintText: StringConstants.password,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: _obscureText
                                              ? Colors.grey
                                              : Colors.deepPurple),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    ),
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) =>
                                      AppFormFieldValidator.emptyFieldValidator(
                                    value,
                                    StringConstants.pleaseEnterPassword,
                                  ),
                                  obscureText: _obscureText,
                                ),
                                (context.height / 45).height,
                                ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.purple),
                                  ),
                                  onPressed: state is LoadingState
                                      ? null
                                      : () => loginButtonPressed(context),
                                  child: Center(
                                    child: Text(
                                      StringConstants.logIn,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
