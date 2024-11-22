import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../app/controllers/home_screen_controller.dart';
import 'post_card.dart';

class PostList extends StatelessWidget {
  final HomeScreenController controller;

  const PostList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: controller.filteredPosts.length,
        itemBuilder: (context, index) {
          final post = controller.filteredPosts[index];
          return PostCard(
            communityName: post['communityName'],
            postTitle: post['postTitle'],
            description: post['description'],
            isImagePost: post['isImagePost'],
            likes: post['likes'].value,
            comments: post['comments'].value,
            onLike: () => controller.likePost(index),
            onComment: () => controller.addComment(index),
            onShare: () {
              print("Shared ${post['postTitle']}");
            },
          );
        },
      ),
    );
  }
}
