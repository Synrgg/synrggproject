import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synergee/widgtes/card.dart';
import 'package:synergee/widgtes/custom_app_bar.dart';
import 'package:synergee/widgtes/custom_bottom_navigator_bar.dart';
import '../controllers/community_screen_controller.dart';
import '../themes/colors.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final CommunityScreenController controller =
  Get.put(CommunityScreenController());

  final List<Map<String, dynamic>> items = List.generate(
    50,
        (index) => {
      'title': 'Card Header',
      'description': 'This is a card description',
      'size': index % 3,
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Fetch background color
      appBar: CustomAppBar(controller: controller),
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column
            Expanded(
              child: Column(
                children: items
                    .asMap()
                    .entries
                    .where((entry) => entry.key % 2 == 0)
                    .map((entry) => ContentCard(
                  item: entry.value,
                ))
                    .toList(),
              ),
            ),
            // Right Column
            Expanded(
              child: Column(
                children: items
                    .asMap()
                    .entries
                    .where((entry) => entry.key % 2 == 1)
                    .map((entry) => ContentCard(
                  item: entry.value,
                ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(controller: controller),
    );
  }
}
