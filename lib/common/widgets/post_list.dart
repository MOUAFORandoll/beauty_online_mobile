import 'package:beauty/common/models/post_model.dart';
import 'package:beauty/common/models/salon_model.dart';
import 'package:beauty/common/widgets/post_item_card.dart';
import 'package:flutter/material.dart';
import 'salon_card.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = PostModel.mockPopular();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: posts.length,
      physics: NeverScrollableScrollPhysics(),
      // separatorBuilder: (_, __) => const SizedBox(width: 16),
      itemBuilder: (_, i) => PostItemCard(post: posts[i]),
    );
  }
}
