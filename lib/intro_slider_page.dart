// import 'package:animated_introduction/animated_introduction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/screens/colours.dart';

import 'screens/playerlist_page.dart';

// final List<SingleIntroScreen> pages = [
//   const SingleIntroScreen(
//     title: 'Welcome to the Event Management App !',
//     description:
//         'You plans your Events, We\'ll do the rest and will be the best! Guaranteed!  ',
//     imageAsset: 'assets/images/purple_bg.jpeg',
//   ),
//   const SingleIntroScreen(
//     title: 'Book tickets to cricket matches and events',
//     description:
//         'Tickets to the latest movies, crickets matches, concerts, comedy shows, plus lots more !',
//     imageAsset: 'assets/images/yellow_bg.jpeg',
//   ),
//   const SingleIntroScreen(
//     title: 'Grabs all events now only in your hands',
//     description: 'All events are now in your hands, just a click away ! ',
//     imageAsset: 'assets/images/green_bg.jpeg',
//   ),
// ];

class IntroPager extends StatefulWidget {
  @override
  State<IntroPager> createState() => _IntroPagerState();
}

class _IntroPagerState extends State<IntroPager> {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              // reverse: true,
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (num) {
                setState(() {
                  _currentIndex = num;
                });
              },
              children: [
                _buildPage(
                    'محلل رياضي آلي',
                    'يقوم بتحليل فيديوهات اللاعب، كتابة نقاط القوة والضعف لديه، وتقديم رسم بياني بالنتيجة',
                    Colors.yellow,
                    'purple_bg'),
                _buildPage(
                    'مساعد مخصص لك',
                    'يقدم لك اقتراحات لتدريبات اللاعبين، كما تستطيع سؤاله بنفسك!',
                    Colors.purple,
                    'yellow_bg'),
                _buildPage('احدث الملاعب بين يديك', 
                'نقدم لك اقتراحات ﻷفضل الملاعب في المملكة، مما يسهل عليك البدء في معسكرك القادم',
                    Colors.green, 'green_bg'),
              ],
            ),

            //nextButton
            Positioned(
                bottom: 15,
                left: 1,
                right: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _currentIndex > 0
                          ? ElevatedButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.linear,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "السابق",
                                  style:
                                      TextStyle(color: mainColor, fontSize: 16),
                                ),
                              ),
                            )
                          : SizedBox(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor
                        ),
                        onPressed: () {
                          _currentIndex == 2
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlayerlistPage(
                                            title: '⚽️ PHOENIX GOAL ⚽️',
                                          )))
                              : _pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.linear,
                                );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _currentIndex < 2 ? "التالي" : "ابدأ الآن",
                            style: TextStyle(
                                color: yellowColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ]))
          ],
        ),
      ),
    );
  }

  void onNextPage() {
    if (_activePage < _currentIndex - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }
  }

  void onPreviousPage() {
    if (_activePage < _currentIndex + 1) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }
  }

  Widget _buildPage(String title, String details, Color color, String bgImage) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage(
                'assets/images/$bgImage.jpeg',
              ),
              alignment: Alignment.bottomCenter,
              fit: BoxFit.cover,
              opacity: 1)),
      child: Center(
        child: Align(
          alignment: _currentIndex == 0 ? Alignment.centerRight :
          _currentIndex == 1 ? Alignment.centerLeft : Alignment.center,
          child: Container(
            width: 400,
            height: 200,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: color,
                borderRadius:
                _currentIndex == 0 ?
                 BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ) : _currentIndex == 1 ? 
                BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ) : BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
                ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: _currentIndex == 0 ? CrossAxisAlignment.start
              : _currentIndex == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: _currentIndex == 0 ? 
                  TextAlign.right : _currentIndex == 1 ?
                  TextAlign.left : TextAlign.center,
                  style: TextStyle(
                    color: _currentIndex == 0 ? Colors.black : Colors.white,
                    fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  details,
                  style: TextStyle(
                    color: _currentIndex == 0 ? Colors.black : Colors.white,
                    fontSize: 18),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
