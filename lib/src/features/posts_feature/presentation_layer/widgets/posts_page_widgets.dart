import 'package:flutter/material.dart';
import '../../../../utils/theme/colors.dart';
import '../../domain_layer/entities/post_entity.dart';
import '../pages/post_details_page.dart';
import 'shared_widgets.dart';

class PostItemWidget extends StatelessWidget {
  const PostItemWidget({Key? key, required this.number, required this.post})
      : super(key: key);
  final int number;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onNavigate(
        context,
        page: PostDetailsPage(post: post),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
              color: mainClr,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                (number + 1).toString(),
                style: const TextStyle(
                  color: whiteClr,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: PostWidgetUtil(post: post),
          ),
        ],
      ),
    );
  }
}

class PostsListWidget extends StatelessWidget {
  const PostsListWidget({
    Key? key,
    required this.posts,
  }) : super(key: key);
  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10.0),
      itemCount: posts.length,
      itemBuilder: (_, index) =>
          PostItemWidget(number: index, post: posts[index]),
      separatorBuilder: (_, index) => const Divider(
        color: mainClr,
        thickness: 2,
        height: 15,
      ),
    );
  }
}

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            minHeight: 50,
          ),
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(
            child: Text(
              message,
              style: const TextStyle(
                color: whiteClr,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
