import 'package:get/get.dart';
import '../controllers/community_screen_controller.dart';

class CommunityScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityScreenController>(() => CommunityScreenController());
  }
}
