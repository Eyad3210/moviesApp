import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:movie_app/views/main_screen/main_screen.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();

  runApp(const MyApp());
}

class MyStorage {
  final box = GetStorage();
  Map<String, dynamic> myData = {};

  void saveData(String id, String title) {
    var data = box.read("data") ?? {};

    if (!data.containsKey(id)) {
      data[id] = title;
      box.write('data', data);
    }
    else{deleteData(id);}
    print(data);
  }

  void deleteData(id) {
    Map<dynamic, dynamic> data = box.read("data") ?? {};

    if (data.containsKey(id)) {
      data.removeWhere((key, value) => key == id);
      box.write('data', data);
    }
    print(data);
  }

  bool isMark(id) {
    Map<dynamic,dynamic> data = box.read("data") ?? {};
    if (!data.containsKey(id)) {
      return false;
    } else {
      return true;
    }
  }

  Map<String, dynamic> getData() {
    myData = box.read('data') ?? {};
    return myData;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const MainScreen(),
    );
  }
}
