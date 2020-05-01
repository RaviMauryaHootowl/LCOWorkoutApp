import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lco_workout/workout.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class WorkoutScreen extends StatefulWidget {
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {

  int currentWorkout = 1;
  int currentSet = 1;
  int time = 100;
  Map data = {};
  List<Workout> wos = [];
  int nOfSets;
  Timer _timer;
  String nextWorkout;
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  void startTimer(){
    const oneSec = const Duration(seconds : 1);
    _timer = new Timer.periodic(oneSec, 
      (Timer timer) => setState(
        (){
          if(time < 1){
            currentWorkout+=1;
            if(currentWorkout == wos.length + 1){
              currentSet+=1;
              if(currentSet > nOfSets){
                currentWorkout = wos.length;
                _timer.cancel();
                assetsAudioPlayer.dispose();
                print('timer is done');
                Navigator.pushNamed(context, '/done');
              }else{
                currentWorkout = 1;
                time = wos[currentWorkout - 1].duration;
              }
            }else{
              time = wos[currentWorkout - 1].duration;
            }
          }else{
            time = time - 1;
          }
          if(currentWorkout >= wos.length - 1){
            if(currentSet == nOfSets){
              nextWorkout = "-";
            }else{
              nextWorkout = wos[0].name;
            }
          }else{
            nextWorkout = (currentWorkout % 2 == 0) ? wos[currentWorkout].name : wos[currentWorkout + 1].name;
          }
          if(currentWorkout % 2 == 0){
            assetsAudioPlayer.pause();
          }else{
            assetsAudioPlayer.play();
          }
        }
      )
    );
  }

  void getData(){
    List ids = data['ids'];
    Workout tempbreak = Workout(15);
    for(int i = 0; i < 5; i++){
      Workout temp = Workout(ids[i]);
      wos.add(temp);
      wos.add(tempbreak);
    }
    nOfSets = data['nOfSets'];
    time = wos[0].duration;
    nextWorkout = wos[1].name;
  }


  @override
  Widget build(BuildContext context) {
    
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    if(wos.isEmpty){
      print('build is ex');
      getData();
      startTimer();
      assetsAudioPlayer.open(
        Audio("assets/audios/pop.mp3"),
      );
      assetsAudioPlayer.loop = true;
      assetsAudioPlayer.play();
    }
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0,20,0,0),
              child: Image.asset(
                'assets/logo.png',
                height: 120,
              ),
            ),
            Text(
              'Exercise ${(currentWorkout/2).ceil()} - Set $currentSet',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 25.0
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: 250,
                      lineWidth: 20.0,
                      percent: time/wos[currentWorkout - 1].duration,
                      center: CircleAvatar(
                        child: Container(
                          child: Image.asset('assets/${wos[currentWorkout - 1].id}.png'),
                          padding: EdgeInsets.all(20.0),
                        ),
                        radius: 105,
                        backgroundColor: HexColor('F9DAFF'),
                      ),
                      backgroundColor: Colors.transparent,
                      progressColor: HexColor('BD21D9'),
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                      animateFromLastPercent: true,
                    ),

                    Container(
                      child: Text(
                        '${wos[currentWorkout - 1].name}',
                        style: GoogleFonts.montserrat(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                          color: HexColor('343434')
                        ),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 40.0, 0, 10.0),
                    ),
                    Container(
                      child: Text(
                        '${(time/60).floor()} : ${time%60}',
                        style: GoogleFonts.montserrat(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                          color: HexColor('BD21D9')
                        ),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 0.0, 0, 10.0),
                    ),
                  ],
                ),
              ) 
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: HexColor('F9DAFF'),
                  width: 3.0
                )
              ),
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  'Next : $nextWorkout',
                  style: GoogleFonts.montserrat(
                    color: HexColor('676767'),
                    fontSize: 20.0
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}