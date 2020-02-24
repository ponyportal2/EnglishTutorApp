import 'package:flutter/material.dart';
import 'package:flutter_youtube_api/screens/enjoy.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String id;

  VideoScreen({this.id});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController _controller;

  /*
  LYRICS LOGIC
  */
  String songText = 'ASS';

  void lyrics() async {
    VoidCallback textChanged;

    String contents = SongLyrics;

    RegExp timings = RegExp(r"(\d\d:\d\d.\d\d)");
    RegExp words = RegExp(r"([a-zA-Z\s\']+[\r\n\z\Z])");
    RegExp ms = RegExp(r"(\d\d)");

    Iterable<RegExpMatch> timingMatches = timings.allMatches(contents);
    Iterable<RegExpMatch> wordMatches = words.allMatches(contents);

    int lenOTim = timingMatches.length;
    int lenOWrd = wordMatches.length;
    int delayMs = 0;
    int prevDelayMs = 0;

    for (var i = lenOTim; i >= 1; i--) {
      var timeStampsRaw =
          timingMatches.elementAt(lenOTim - i).group(0).toString();
      Iterable<RegExpMatch> timeStamps = ms.allMatches(timeStampsRaw);
      timeStamps = timeStamps.toList();

      String minutes;
      String seconds;
      String milliseconds;
      int intMinutes = 0;
      int intSeconds = 0;
      int intMilliseconds = 0;
      int tempDelayMs = 0;

      for (var i = 0; i <= 2; i++) {
        if (i == 0) {
          minutes = timeStamps.elementAt(0).group(0).toString();
          if (minutes[0] == '0') {
            intMinutes = int.parse(minutes[1]);
          } else {
            intMinutes = int.parse(minutes);
          }
        }
        if (i == 1) {
          seconds = timeStamps.elementAt(1).group(0).toString();
          if (seconds[0] == '0') {
            intSeconds = int.parse(seconds[1]);
          } else {
            intSeconds = int.parse(seconds);
          }
        }
        if (i == 2) {
          milliseconds = timeStamps.elementAt(2).group(0).toString();
          if (milliseconds[0] == '0') {
            intMilliseconds = int.parse(milliseconds[1]);
          } else {
            intMilliseconds = int.parse(milliseconds);
          }
        }
      }

      if (i == lenOTim) {
        delayMs =
            (intMilliseconds * 10) + (((intMinutes * 60) + intSeconds) * 1000);
        prevDelayMs = delayMs;
      } else {
        tempDelayMs =
            (intMilliseconds * 10) + (((intMinutes * 60) + intSeconds) * 1000);
        delayMs = tempDelayMs - prevDelayMs;
        prevDelayMs = tempDelayMs;
      }

      await new Future.delayed(Duration(milliseconds: delayMs));
//      textChanged();
      setState(() {
        songText = wordMatches.elementAt(lenOWrd - i).group(0).toString();
      });
    }
  }
  /*
  END OF LYRICS LOGIC
  */

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        controlsVisibleAtStart: false,
        forceHideAnnotation: true,
        hideControls: true,
        hideThumbnail: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: GestureDetector(
              onTap: () {
                print('ass');
              },
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: false,
                bottomActions: [],
                topActions: [],
                onReady: () {},
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                _controller.play();
                await new Future.delayed(
                    Duration(seconds: 1, milliseconds: 300));
                lyrics();
              },
              child: Container(
                constraints: BoxConstraints.expand(),
                color: Colors.green,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    songText,
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(1.0, 1.0),
                        )
                      ],
                      color: Colors.white,
                    ),
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
