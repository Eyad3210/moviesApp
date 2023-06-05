import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BookMarkController extends GetxController {
  var myMap = {}.obs;
  final box = GetStorage();
  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() async {
    final myMapData = await box.read('data');

    if (myMapData != null && myMapData is Map<String, dynamic>) {
      myMap.value = myMapData;
    } else {
      myMap.value = {};
    }
  }


  /* void delete(id){
    if(myMap.containsKey(id)){
      myMap.removeWhere((key, value) => key==id);
    }
  } */
}
