import 'package:flutter/material.dart';
import '../../domain_layer/entities/post_entity.dart';
import '../widgets/post_details_page_widgets.dart';
import '../widgets/shared_widgets.dart';

class PostDetailsPage extends StatelessWidget {
  const PostDetailsPage({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarUtil(title: 'Post Details'),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            PostWidgetUtil(post: post),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UpdatePostButtonWidget(post: post),
                DeletePostButtonWidget(postId: post.id!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
