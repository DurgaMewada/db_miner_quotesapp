import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui';

import '../../controller/quotes_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    PageController pageController = PageController();

    GlobalKey globalKey = GlobalKey();

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    var controller = Get.put(QuotesController());
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff060A12),
              ),
              child: Center(
                child: RepaintBoundary(
                  key: globalKey,
                  child: SizedBox(
                    height: height * 0.4,
                    width: width * 0.9,
                    child: Obx(() {
                      if (controller.quoteList.isEmpty) {
                        return Center(
                          child: Text(
                            "No quotes available",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }

                      return PageView.builder(
                        controller: pageController,
                        itemCount: controller.quotes.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.all(height * 0.01),
                              height: height * 0.3,
                              width: screenWidth * 0.8,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: ClipRect(
                                child: BackdropFilter(
                                  filter:
                                  ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.selectQuote(index);
                                        },
                                        child: Text(
                                          controller.quotes[index].category,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: height * 0.15,
                                        padding: EdgeInsets.all(width * 0.05),
                                        margin: EdgeInsets.all(width * 0.02),
                                        child: Center(
                                          child: Text(
                                            controller.quotes[index].quote,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: width * 0.05,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "- ${controller.quotes[index].author}",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: width * 0.05,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Obx(
                                                  () => IconButton(
                                                onPressed: () {
                                                  controller
                                                      .addQuoteToFavourites(
                                                      controller
                                                          .quotes[index]);
                                                  controller
                                                      .markQuoteAsFavorite(
                                                      index);
                                                },
                                                icon: (controller.quotes[index]
                                                    .isFavorite)
                                                    ? Icon(
                                                  Icons.favorite,
                                                  color: Colors.red[900],
                                                )
                                                    : const Icon(
                                                  Icons.favorite_outline,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.copy,
                                                  color: Colors.black),
                                              onPressed: () {
                                                Clipboard.setData(
                                                  ClipboardData(
                                                      text: controller
                                                          .quotes[index].quote),
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.edit,
                                                  color: Colors.black),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}