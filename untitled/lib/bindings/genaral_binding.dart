import 'package:get/get.dart';
import 'package:untitled/utils/Network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }

}