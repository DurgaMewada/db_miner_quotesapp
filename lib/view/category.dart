import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/quotes_controller.dart';
import '../../utils/globals.dart';

class Category extends StatelessWidget {
  final QuotesController controller = Get.put(QuotesController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xffF9A825),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff060A12), // Background color applied
        ),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: category.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 20,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    if (category[index]['category'] == 'General') {
                      controller.quotes.value = controller.quoteList;
                    } else {
                      controller.quotes.value = controller.quoteList
                          .where((quote) =>
                      quote.category == category[index]['category'])
                          .toList();
                    }
                    controller.quotes.refresh();
                    Get.toNamed('/ho');
                  },
                  child: Container(
                    height: height * 0.1 - 20,
                    width: width * 0.3,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1), // Translucent card background
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        category[index]['category']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}