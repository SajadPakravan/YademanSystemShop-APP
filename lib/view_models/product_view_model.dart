import 'package:get/get.dart';
import 'package:yad_sys/screens/product/product_images_screen.dart';
import 'package:yad_sys/screens/product/product_info_screen.dart';

class ProductViewModel {
  onTapProductInfo({required int content, required String description, required List attributes}) async {
    Get.to(
      const ProductInfoScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500),
      arguments: {"content": content, "description": description, "attributes": attributes},
    );
  }

  onTapProductImage({required int imageIndex, required List images}) async {
    Get.to(
      const ProductImagesScreen(),
      transition: Transition.size,
      duration: const Duration(seconds: 1),
      arguments: {"imageIndex": imageIndex, "images": images},
    );
  }
}
