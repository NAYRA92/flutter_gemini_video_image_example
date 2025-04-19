import 'dart:typed_data';

import 'package:d_chart/commons/data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/services/gemini_service.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiProvider extends ChangeNotifier {
  static GenerativeModel _initModel() {
    // final key = dotenv.env['GEMINI_API_KEY'];
    final key = "AIzaSyCJJDVNUWUoX53GXIKbKYD7Jam6BwqBrWo";

    if (key!.isEmpty) {
      throw Exception('GEMINI_API_KEY not found');
    }
    return GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: key,
    );
  }
List<int> indicatorList = []; 
  static final _geminiService = GeminiService(model: _initModel());

  String? response;
  List<String>? indicator_list;
  List<OrdinalData> ordinalDataList = [] ;
  bool isLoading = false;

  Future<void> generateContentFromText({
    required String prompt,
  }) async {
    isLoading = true;
    notifyListeners();
    response = null;
    indicator_list = null;
    response = await _geminiService.generateContentFromText(prompt: prompt);
    isLoading = false;
    notifyListeners();
  }

  Future<void> generateContentFromImage({
    required String prompt,
    required Uint8List bytes,
  }) async {
    isLoading = true;
    notifyListeners();
    response = null;
    indicator_list = null;
    // ordinalDataList = null;
    final dataPart = DataPart(
      'video/',
      // 'image/jpeg',
      bytes,
    );

    response = await _geminiService.generateContentFromImage(
      prompt: prompt,
      dataPart: dataPart,
    );

    print(response);


  indicator_list = extractNumbers(response!);
  print("Extracted Numbers: $indicator_list");

  for(int i = 0; i < indicator_list!.length; i++){
   ordinalDataList.add(
    OrdinalData(
      domain: 'Item $i',
      measure: int.parse(indicator_list![i]) ,
      color: int.parse(indicator_list![i]) <= 25
          ? Colors.red[200]
          : int.parse(indicator_list![i]) <= 50
              ? Colors.orangeAccent[200]
              : int.parse(indicator_list![i]) <= 80
              ? Colors.blue[200]
              : Colors.green[200],
    ),);
  }

  //   ordinalDataList = [
  //   OrdinalData(
  //     domain: 'A',
  //     measure: int.parse(indicator_list![0]) ,
  //     color: int.parse(indicator_list![0]) <= 25
  //         ? Colors.red[200]
  //         : int.parse(indicator_list![0]) <= 50
  //             ? Colors.orangeAccent[200]
  //             : int.parse(indicator_list![0]) <= 80
  //             ? Colors.blue[200]
  //             : Colors.green[200],
  //   ),
  //   OrdinalData(
  //     domain: 'B',
  //     measure: int.parse(indicator_list![1]),
  //     color: int.parse(indicator_list![1]) <= 25
  //         ? Colors.red[200]
  //         : int.parse(indicator_list![1]) <= 50
  //             ? Colors.orangeAccent[200]
  //             : int.parse(indicator_list![1]) <= 80
  //             ? Colors.blue[200]
  //             : Colors.green[200],
  //   ),
  //   OrdinalData(
  //     domain: 'C',
  //     measure: int.parse(indicator_list![2]),
  //     color: int.parse(indicator_list![2]) <= 25
  //         ? Colors.red[200]
  //         : int.parse(indicator_list![2]) <= 50
  //             ? Colors.orangeAccent[200]
  //             : int.parse(indicator_list![2]) <= 80
  //             ? Colors.blue[200]
  //             : Colors.green[200],
  //   ),
  // ];

    isLoading = false;
    notifyListeners();
  }

  void reset() {
    response = null;
    isLoading = false;
    notifyListeners();
  }
}

List<String> extractNumbers(String text) {
  RegExp regExp = RegExp(r'\b\d+\b'); // Matches one or more digits as a whole word
  Iterable<Match> matches = regExp.allMatches(text);
  return matches.map((match) => match.group(0)!).toList();
}