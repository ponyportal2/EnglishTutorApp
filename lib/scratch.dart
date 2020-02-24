//import 'dart:io';
//
//void main() {
//  print(timings());
//}
//
////Future<String> loadAsset() async {
////  return await rootBundle.loadString('assets/my_text.txt');
////}
//
////RegExp _numeric = RegExp(r'^-?[0-9]+$');
//
//List timings() {
//  String contents = new File('assets/enjoy.dart').readAsStringSync();
//
//  RegExp timings = RegExp(r"(\d\d:\d\d.\d\d)");
//  RegExp words = RegExp(r"([a-zA-Z\s\']+[\r\n\z\Z])");
//  RegExp ms = RegExp(r"(\d\d)");
//
//  Iterable<RegExpMatch> timingMatches = timings.allMatches(contents);
//  Iterable<RegExpMatch> wordMatches = words.allMatches(contents);
//
//  int lenOTim = timingMatches.length;
//  int lenOWrd = wordMatches.length;
//  int delayMs = 0;
//  int prevDelayMs = 0;
//
//  String lyrics() {
//    for (var i = lenOTim; i >= 1; i--) {
//      var timeStampsRaw =
//          timingMatches.elementAt(lenOTim - i).group(0).toString();
//      Iterable<RegExpMatch> timeStamps = ms.allMatches(timeStampsRaw);
//      timeStamps = timeStamps.toList();
//
//      String minutes;
//      String seconds;
//      String milliseconds;
//      int intMinutes = 0;
//      int intSeconds = 0;
//      int intMilliseconds = 0;
//      int tempDelayMs = 0;
//
//      for (var i = 0; i <= 2; i++) {
//        if (i == 0) {
//          minutes = timeStamps.elementAt(0).group(0).toString();
//          if (minutes[0] == '0') {
//            intMinutes = int.parse(minutes[1]);
//          } else {
//            intMinutes = int.parse(minutes);
//          }
//        }
//        if (i == 1) {
//          seconds = timeStamps.elementAt(1).group(0).toString();
//          if (seconds[0] == '0') {
//            intSeconds = int.parse(seconds[1]);
//          } else {
//            intSeconds = int.parse(seconds);
//          }
//        }
//        if (i == 2) {
//          milliseconds = timeStamps.elementAt(2).group(0).toString();
//          if (milliseconds[0] == '0') {
//            intMilliseconds = int.parse(milliseconds[1]);
//          } else {
//            intMilliseconds = int.parse(milliseconds);
//          }
//        }
//      }
//
//      if (i == lenOTim) {
//        delayMs =
//            (intMilliseconds * 10) + (((intMinutes * 60) + intSeconds) * 1000);
//        prevDelayMs = delayMs;
//      } else {
//        tempDelayMs =
//            (intMilliseconds * 10) + (((intMinutes * 60) + intSeconds) * 1000);
//        delayMs = tempDelayMs - prevDelayMs;
//        prevDelayMs = tempDelayMs;
//      }
//
//      sleep(Duration(milliseconds: delayMs));
//      print(wordMatches.elementAt(lenOWrd - i).group(0).toString());
//
//      return wordMatches.elementAt(lenOWrd - i).group(0).toString();
//    }
//  }
//
//  return lyrics();
//}
