import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/quotes_controller.dart';
import '../model/quote_model.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(QuotesController());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'My Favorites',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: const Color(0xff060A12), // Background color
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(() {
                  if (controller.likeQuotes.isEmpty) {
                    return Center(
                      child: const Text(
                        'No favorite quotes added yet.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70, // Subtle text color
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    );
                  }

                  Map<String, List<QuotesModel>> groupedQuotes = {};
                  for (var quote in controller.likeQuotes) {
                    if (groupedQuotes.containsKey(quote.category)) {
                      groupedQuotes[quote.category]!.add(quote);
                    } else {
                      groupedQuotes[quote.category] = [quote];
                    }
                  }

                  return ListView.builder(
                    itemCount: groupedQuotes.keys.length,
                    itemBuilder: (context, index) {
                      String category = groupedQuotes.keys.elementAt(index);

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900, // Darker background
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                category,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth * 0.06,
                                  color: Colors.white,
                                ),
                              ),
                              const Divider(
                                color: Colors.white54,
                                thickness: 1.5,
                                height: 20,
                              ),
                              ...groupedQuotes[category]!.map((quote) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.01,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(screenWidth * 0.03),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade800,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                quote.quote,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: screenWidth * 0.045,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                '- ${quote.author}',
                                                style: TextStyle(
                                                  color: Colors.white54,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: screenWidth * 0.035,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                              title: 'Delete Quote',
                                              content: Text(
                                                'Are you sure you want to delete this quote?',
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.04,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              confirm: ElevatedButton(
                                                onPressed: () {
                                                  controller.deleteFavouriteQuote(quote.id!);
                                                  Get.back();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.redAccent,
                                                ),
                                                child: const Text('Yes'),
                                              ),
                                              cancel: ElevatedButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.grey,
                                                ),
                                                child: const Text('No'),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}