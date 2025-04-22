// import 'package:animated_introduction/animated_introduction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/screens/colours.dart';

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
  PageController controller=PageController();

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
            controller: controller,
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
                  'Chatbot Feature',
                  'Offers training steps and advice for players.',
                  Colors.purple,
                  'yellow_bg'),
              _buildPage('Stadium List', 'Provides a list of stadiums.',
                  Colors.green, 'green_bg'),
            ],
            ),

            //nextButton
            ElevatedButton(onPressed: (){}, child: Text("التالي"))
          ],
        ),
      ),
    );
  }

  Widget _buildPage(String title, 
  String details, 
  Color color, 
  String bgImage) {
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
          alignment: Alignment.centerRight,
          child: Container(
            width: 400,
            height: 200,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  details,
                  style: TextStyle(fontSize: 18),
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
