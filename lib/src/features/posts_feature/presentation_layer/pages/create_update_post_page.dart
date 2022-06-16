import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_app/src/features/posts_feature/presentation_layer/bloc/post_bloc/post_bloc.dart';
import 'package:tdd_app/src/features/posts_feature/presentation_layer/bloc/post_bloc/post_state.dart';
import 'package:tdd_app/src/features/posts_feature/presentation_layer/pages/posts_page.dart';
import 'package:tdd_app/src/features/posts_feature/presentation_layer/widgets/create_update_post_page_widgets.dart';
import '../../domain_layer/entities/post_entity.dart';
import '../widgets/shared_widgets.dart';

class CreateOrUpdatePostPage extends StatelessWidget {
  const CreateOrUpdatePostPage({Key? key, this.post, this.isUpdate = false})
      : super(key: key);
  final Post? post;
  final bool isUpdate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarUtil(title: isUpdate ? 'Update Post' : 'Create Post'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostSuccessState) {
          showSnackBar(context, message: state.message, color: Colors.green);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const PostsPage()),
              (route) => false);
        } else if (state is PostErrorState) {
          showSnackBar(context,
              message: state.message, color: Colors.redAccent);
        }
      },
      builder: (context, state) {
        if (state is PostLoadingState) {
          return const LoadingUtil();
        } else {
          return FormWidget(
            isUpdate: isUpdate,
            post: post,
          );
        }
      },
    );
  }
}

/*
Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: whiteClr,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(1, 1),
                      color: Colors.black26,
                      blurRadius: 2,
                      spreadRadius: 3)
                ],
              ),
              child: const LoadingUtil(),
            ),
          );*/
