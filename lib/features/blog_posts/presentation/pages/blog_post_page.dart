import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unlockd_assignment/core/constants/app_alerts.dart';
import 'package:unlockd_assignment/core/constants/string_constants.dart';
import 'package:unlockd_assignment/core/utils/extension.dart';
import 'package:unlockd_assignment/core/utils/helper_function.dart';
import 'package:unlockd_assignment/core/widget/loading_screen_widget.dart';
import 'package:unlockd_assignment/core/widget/network_image_view.dart';
import 'package:unlockd_assignment/features/auth/presentation/pages/login_page.dart';

import 'package:unlockd_assignment/features/blog_posts/presentation/bloc/blog_post_bloc.dart';
import 'package:unlockd_assignment/injection_container.dart';

class BlogPostPage extends StatelessWidget {
  const BlogPostPage({super.key});
// Naviage to  login page
  void _logout(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<BlogPostBloc>()..add(const OnblogPostFetch()),
      child: GestureDetector(
          onTap: hideKeyBoard,
          child: BlocConsumer<BlogPostBloc, BlogPostState>(
              listener: (context, state) {
            if (state is BlogPostFailed) {
              AppAlerts.showErrorSnackBar(state.message);
            } else if (state is LogouFailed) {
              AppAlerts.showErrorSnackBar(state.message);
            } else if (state is LogOutSuccess && state.logoutUser) {
              _logout(context);
            }
          }, builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  StringConstants.blogsPosts,
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        context
                            .read<BlogPostBloc>()
                            .add(const OnblogOutPressed());
                      },
                      icon: const Icon(Icons.logout_outlined))
                ],
              ),
              body: LoadingScreenView(
                // show CircularProgressIndicator is state  is  loading
                isLoading: state is BlogLoadingState,
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: (context.width * .07),
                  ),
                  //show message if there is posts
                  child: context.read<BlogPostBloc>().posts == null ||
                          context.read<BlogPostBloc>().posts!.isEmpty
                      ? const Center(
                          child: Text(StringConstants.noBlogPostFound),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount:
                              context.read<BlogPostBloc>().posts?.length ?? 0,
                          itemBuilder: (context, index) {
                            final blog =
                                context.read<BlogPostBloc>().posts?[index];

                            return Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  border: Border.all(
                                      color: Colors.purpleAccent.shade100),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: context.width * .2,
                                    height: context.width * .2,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: NetworkImageView(blog?.imageUrl),
                                  ),
                                  10.width,
                                  Expanded(
                                    child: SizedBox(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            blog?.title.toUpperCase() ?? "",
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                                ?.copyWith(color: Colors.black),
                                          ),
                                          5.height,
                                          Text(
                                              blog?.description.toUpperCase() ??
                                                  "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                )),
              ),
            );
          })),
    );
  }
}
