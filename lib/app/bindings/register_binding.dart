import 'package:get/get.dart';
import 'package:synergee/app/controllers/registry_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}
