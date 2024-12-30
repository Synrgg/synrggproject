import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgtes/custom_app_bar.dart';
import '../../widgtes/custom_bottom_navigator_bar.dart';
import '../../widgtes/custom_drawer.dart';
import '../../widgtes/floating_action_menu.dart';
import '../../widgtes/post_list.dart';
import '../controllers/community_screen_controller.dart';

class CommunityScreen extends StatelessWidget {
  final CommunityScreenController controller =
      Get.find<CommunityScreenController>();

  CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: CustomAppBar(controller: controller),
          drawer: CustomDrawer(controller: controller),
          body: PostList(controller: controller),
          bottomNavigationBar:
              CustomBottomNavigationBar(controller: controller),
          floatingActionButton: FloatingActionMenu(controller: controller),
        );
      },
    );
  }
}
