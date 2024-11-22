import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgtes/custom_app_bar.dart';
import '../../widgtes/custom_bottom_navigator_bar.dart';
import '../../widgtes/custom_drawer.dart';
import '../../widgtes/floating_action_menu.dart';
import '../../widgtes/post_list.dart';
import '../controllers/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: CustomAppBar(controller: controller),
          drawer: CustomDrawer(controller: controller),
          body: PostList(controller: controller),
          bottomNavigationBar: CustomBottomNavigationBar(controller: controller),
          floatingActionButton: FloatingActionMenu(controller: controller),
        );
      },
    );
  }
}
