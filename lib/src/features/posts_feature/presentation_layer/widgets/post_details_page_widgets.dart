import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/theme/colors.dart';
import '../../domain_layer/entities/post_entity.dart';
import '../bloc/post_bloc/post_bloc.dart';
import '../bloc/post_bloc/post_event.dart';
import '../bloc/post_bloc/post_state.dart';
import '../pages/create_update_post_page.dart';
import '../pages/posts_page.dart';
import 'create_update_post_page_widgets.dart';
import 'shared_widgets.dart';

class UpdatePostButtonWidget extends StatelessWidget {
  const UpdatePostButtonWidget({Key? key, required this.post})
      : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonUtil(
      color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.edit,
            size: 22,
            color: whiteClr,
          ),
          SizedBox(width: 10),
          Text(
            'Update',
            style: TextStyle(
              color: whiteClr,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      onClick: () => onNavigate(context,
          page: CreateOrUpdatePostPage(
            isUpdate: true,
            post: post,
          )),
    );
  }
}

class DeletePostButtonWidget extends StatelessWidget {
  const DeletePostButtonWidget({Key? key, required this.postId})
      : super(key: key);
  final int postId;

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonUtil(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.delete,
            size: 22,
            color: whiteClr,
          ),
          SizedBox(width: 10),
          Text(
            'Delete',
            style: TextStyle(
              color: whiteClr,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      onClick: () => _onDeletePost(context, postId: postId),
    );
  }

  void _onDeletePost(BuildContext context, {required int postId}) {
    showDialog(
        context: context,
        builder: (_) {
          return BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state is PostSuccessState) {
                showSnackBar(context,
                    message: state.message, color: Colors.green);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const PostsPage()),
                    (route) => false);
              } else if (state is PostErrorState) {
                onPop(context);
                showSnackBar(context,
                    message: state.message, color: Colors.red);
              }
            },
            builder: (context, state) {
              final PostBloc bloc = PostBloc.get(context);
              if (state is PostLoadingState) {
                return const AlertDialog(
                  title: LoadingUtil(),
                );
              } else {
                return AlertDialog(
                  title: const Text('Are you sure ?'),
                  titleTextStyle: const TextStyle(
                    color: blackClr,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  actions: [
                    ElevatedButtonUtil(
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: whiteClr),
                      ),
                      onClick: () => bloc.add(DeletePostEvent(postId: postId)),
                    ),
                    ElevatedButtonUtil(
                      child: const Text(
                        'No',
                        style: TextStyle(color: whiteClr),
                      ),
                      onClick: () => onPop(context),
                    ),
                  ],
                );
              }
            },
          );
        });
  }
}
