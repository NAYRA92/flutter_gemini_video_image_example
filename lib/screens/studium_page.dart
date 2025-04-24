import 'package:flutter/material.dart';
import 'package:flutter_gemini/screens/colours.dart';

class StudiumPage extends StatefulWidget {
  const StudiumPage({super.key});

  @override
  State<StudiumPage> createState() => _StudiumPageState();
}

List<String> studiumTitle = [
  'ملعب الإنماء',
  'استاد الأمير محمد بن فهد',
  'ملعب جامعة الملك سعود',
  'ملاعب مدينة الأمير سلطان بن عبدالعزيز',
  'مدينة الملك عبدالله الرياضية',
];

List<String> studiumPlaces = [
  'جدة',
  'الدمام',
  'الرياض',
  'أبها',
  'بريدة',
];

List<String> studiumDetails = [
  //1
  '''
• 💡 الفكرة: مثالي لمعسكر لاعبين يحتاجون تحسين الأداء تحت الضغط.

 • 🏖 البيئة: قريب من البحر الأحمر – إمكانية إقامة تدريبات صباحية + تحليل فيديوهات الأداء داخل مرافق الاستاد.

 • 🗺 أماكن سياحية في المدينة: كورنيش جدة – البلد التاريخية – مطاعم بحرية.''',

  //2
  '''
• 💡 الفكرة: معسكرات تكتيكية + اختبارات تحمل في أجواء رطبة لمحاكاة ظروف الملاعب الساحلية.

• 🏖 البيئة: قريب من البحر – مناسب للاعبين المحترفين للتحضير للمباريات الحاسمة.

• 🗺 أماكن سياحية: كورنيش الدمام – جزيرة المرجان – قرية الدغيثر.

''',

//3
  '''
 • 💡 الفكرة: مرافق متطورة واجواء اكاديمية مثالية للتركيز على الجانب التكتيكي.

 • 🏖 البيئة: بيئة جامعية تساعد على الجمع بين المحاضرات التكتيكية والتدريب العملي ومثالي لتطوير ذكاء الملعب.

 • 🗺 أماكن سياحية في المدينة: قريبة من مراكز تسوق وسكن للضيوف الدوليين.''',

  //4
  '''
 • 💡 الفكرة: معسكرات هادئة لزيادة التركيز والذكاء الحركي.

 • 🏖 البيئة: أجواء باردة – تساعد على صفاء الذهن.

 • 🗺 اماكن سياحية في المدينة : السودة – الجبل الأخضر – الفعاليات الصيفية.

''',

  //5
  '''
 • 💡 الفكرة: احترافية بامتياز وتحاكي أجواء البطولات.

 • 🏖 البيئة: ممتاز للاعبين الذين يستعدون لبطولات أو مباريات حاسمة. الملاعب الإحترافية والبنية التحتية تعطيهم احساس اللعب في أعلى المستويات مما يرفع جاهزيتهم الذهنية والفنية.
 
 • 🗺 أماكن سياحية في المدينة: الأنشطة الريفية – سوق المسوكف الشعبي – جلسات تراثية.
''',
];

List<String> studiumImages = [
  'assets/images/studium1.jpg',
  'assets/images/studium7.jpeg',
  'assets/images/studium4.jpg',
  'assets/images/studium3.jpg',
  'assets/images/studium5.jpg',
];

int _currentImageIndex = 0;
bool opacityCheck = true;

class _StudiumPageState extends State<StudiumPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage(
                'assets/images/soccer_pattern.jpeg',
              ),
              alignment: Alignment.bottomCenter,
              fit: BoxFit.cover,
              opacity: .3)),
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: studiumImages.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentImageIndex = index;
                              opacityCheck = false;
                            });
                          },
                          child: Container(
                            width: 450,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black,
                                image: DecorationImage(
                                    image: AssetImage(studiumImages[index]),
                                    opacity:
                                        _currentImageIndex == index ? 1 : .5,
                                    fit: BoxFit.cover)),
                          ),
                        );
                      })),

              //details
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        _currentImageIndex == 0
                            ? studiumTitle[0]
                            : _currentImageIndex == 1
                                ? studiumTitle[1]
                                : _currentImageIndex == 2
                                    ? studiumTitle[2]
                                    : _currentImageIndex == 3
                                        ? studiumTitle[3]
                                        : studiumTitle[4],
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),

                      //places
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentImageIndex == 0
                                ? studiumPlaces[0]
                                : _currentImageIndex == 1
                                    ? studiumPlaces[1]
                                    : _currentImageIndex == 2
                                        ? studiumPlaces[2]
                                        : _currentImageIndex == 3
                                            ? studiumPlaces[3]
                                            : studiumPlaces[4],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Icon(Icons.place_rounded)
                        ],
                      ),

                      //details
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Card(
                            color: yellowColor,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                _currentImageIndex == 0
                                    ? studiumDetails[0]
                                    : _currentImageIndex == 1
                                        ? studiumDetails[1]
                                        : _currentImageIndex == 2
                                            ? studiumDetails[2]
                                            : _currentImageIndex == 3
                                                ? studiumDetails[3]
                                                : studiumDetails[4],
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
