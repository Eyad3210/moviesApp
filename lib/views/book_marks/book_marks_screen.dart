import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/views/details_screen/details_screen.dart';

import '../../controllers/book_mark_controller.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  var conroller = Get.put(BookMarkController());

  @override
  void initState() {
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         
          title: const Text("My Bookmarks"),
          backgroundColor: Colors.red[900],
          leading: GestureDetector(onTap: () {
          Navigator.pop(context);

          }, child: const Icon(Icons.arrow_back)),
        ),
        body: Obx(
      () => conroller.myMap.isNotEmpty
          ? ListView.builder(
              itemCount: conroller.myMap.length,
              itemBuilder: (context, index) {
                final id = conroller.myMap.keys.elementAt(index);
                //final title = conroller.myMap.values.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.off(DetailsScreen(movieId: int.parse(id)));
                    },
                    child: Container(
                      color: Colors.grey[200],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Text(conroller.myMap.values.elementAt(index)),
                          ),
                          IconButton(
                              onPressed: () {
                                storage.deleteData(id);
                                setState(() {});
                                print(storage.getData());
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.blueGrey,
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text("There are no favorite movies"),
            ),
    ));
  }
}
