import 'package:flutter/material.dart';
import 'dart:async';

enum TimerMode { single, queue }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meditation Timer Plus',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Meditation Timer Plus'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stopwatch stopwatch = Stopwatch();

  Timer? countdownTimer;
  Duration defaultTime = Duration(seconds: 30);
  Duration countdownTimerRemaining = Duration.zero;
  List<Duration> countdownQueue = [];
  TimerMode currentMode = TimerMode.single;

  int currentIndex = 0;

  bool isRunning = false;
  bool isFirstRun = true;
  IconData currentIcon = Icons.play_circle_fill;
  bool countdownFinished = false;

  void toggleTimers () {
    print("Icon now start toggle: $currentIcon, isRunning: $isRunning");
    setState(() {
      if (isRunning) {
        pauseTimers();
        currentIcon = Icons.play_circle_filled;
        print("pause");
      } else {
        startTimers();
        currentIcon = Icons.pause_circle_filled;
        print("play");
      }
      isRunning = !isRunning;
    });
    print("Icon now end toggle: $currentIcon, isRunning: $isRunning \n break");
  }

  void startTimers() {
    stopwatch.start();
    countdownTimer?.cancel(); 

    if (countdownQueue.isNotEmpty) {
      currentMode = TimerMode.queue;
      countdownTimerRemaining = countdownQueue.removeAt(0);
    } else if (isFirstRun == true) {
      currentMode = TimerMode.single;
      countdownTimerRemaining = defaultTime;
      isFirstRun = false;
    } else {
      currentMode = TimerMode.single;
      if (countdownTimerRemaining <= Duration.zero) {
        countdownTimerRemaining = defaultTime;
      }
    }
    print("Timer started with ${countdownTimerRemaining.inSeconds}");

    countdownTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _tickTimer(timer);
      setState(() {});
    });
  }

  void _tickTimer(Timer timer) {
    if (countdownTimerRemaining > Duration.zero) {
      countdownTimerRemaining -= Duration(seconds: 1);
    } else if (currentMode == TimerMode.queue && countdownQueue.isNotEmpty) {
      countdownTimerRemaining = countdownQueue.removeAt(0);
    } else {
      countdownTimerRemaining = Duration.zero;
      currentIcon = Icons.play_circle_fill;
      timer.cancel();
    }
  }

  void pauseTimers () {
    setState(() {
      stopwatch.stop();
      countdownTimer?.cancel();
    });
  }

  void resetTimers() {
    setState(() {
      stopwatch.stop();
      stopwatch.reset();
      countdownTimer?.cancel();
      print("default time in reset func: $defaultTime");
      countdownTimerRemaining = defaultTime;
      print("time remaining: ${countdownTimerRemaining.inSeconds}");
      isRunning = false;
      currentIcon = Icons.play_circle_fill;
    });
    print("state reset");
  }

  @override
  void initState() {
    super.initState();
    countdownTimerRemaining = defaultTime;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Time Remaining: ${countdownTimerRemaining.inSeconds} seconds",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20,),
            Text(
              "Stopwatch: ${stopwatch.elapsed.inSeconds}",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: toggleTimers,
                  icon: Icon(currentIcon),
                ),
                SizedBox(width: 15,),
                IconButton(
                  onPressed: resetTimers,
                  icon: Icon(Icons.stop_circle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
