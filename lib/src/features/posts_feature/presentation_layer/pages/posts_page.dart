import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_app/src/features/posts_feature/presentation_layer/bloc/posts_bloc/posts_bloc.dart';
import 'package:tdd_app/src/features/posts_feature/presentation_layer/bloc/posts_bloc/posts_event.dart';
import 'package:tdd_app/src/features/posts_feature/presentation_layer/bloc/posts_bloc/posts_state.dart';
import 'package:tdd_app/src/features/posts_feature/presentation_layer/pages/create_update_post_page.dart';
import '../../../../utils/theme/colors.dart';
import '../widgets/posts_page_widgets.dart';
import '../widgets/shared_widgets.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarUtil(title: 'Posts'),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<PostsBloc, PostsStates>(
      builder: (context, state) {
        final PostsBloc bloc = PostsBloc.get(context);
        if (state is PostsInitialState) {
          bloc.add(GetAllPostsEvent());
          return const LoadingUtil();
        } else if (state is PostsLoadingState) {
          return const LoadingUtil();
        } else if (state is PostsLoadedState) {
          return RefreshIndicator(
            onRefresh: () async => bloc.add(RefreshPostsEvent()),
            child: PostsListWidget(
              posts: state.posts,
            ),
          );
        } else if (state is PostsErrorState) {
          return ErrorMessageWidget(
            message: state.message,
          );
        } else {
          return const ErrorMessageWidget(
            message: 'state.message',
          );
        }
      },
    );
  }

  FloatingActionButton _buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.add,
        color: whiteClr,
        size: 30,
      ),
      onPressed: () => onNavigate(
        context,
        page: const CreateOrUpdatePostPage(),
      ),
    );
  }
}
