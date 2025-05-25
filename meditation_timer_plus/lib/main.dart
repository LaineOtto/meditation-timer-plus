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

  bool isRunning = false;
  bool isFirstRun = true;
  IconData currentIcon = Icons.play_circle_fill;
  bool countdownFinished = false;

  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    countdownTimerRemaining = defaultTime;
  }

  void toggleTimers() {
    setState(() {
      if (isRunning) {
        pauseTimers();
        currentIcon = Icons.play_circle_filled;
      } else {
        startTimers();
        currentIcon = Icons.pause_circle_filled;
      }
      isRunning = !isRunning;
    });
  }

  void startTimers() {
    print("start");
    stopwatch.start();
    countdownTimer?.cancel(); 

    if (countdownQueue.isNotEmpty && isFirstRun == true) {
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

  void pauseTimers() {
    print("pause");
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
    // This method is rerun every time setState is called

    List<Widget> pages = [_buildTimerPage(), _buildSettingsPage()];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(child: pages[_currentPageIndex]),

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onNavBarTap,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.timer_sharp), label: 'Timer'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        selectedIndex: _currentPageIndex,
      ),
    );
  }

  // Main Page
  Widget _buildTimerPage() {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Time Remaining: ${countdownTimerRemaining.inSeconds} seconds",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
        SizedBox(height: 20),
            Text(
              "Stopwatch: ${stopwatch.elapsed.inSeconds}",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
        SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 72,
                  onPressed: toggleTimers,
                  icon: Icon(currentIcon),
                ),
            SizedBox(width: 15),
                IconButton(
                  iconSize: 72,
                  onPressed: resetTimers,
                  icon: Icon(Icons.stop_circle),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Settings Page :)",
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
      ),
      ],
    );
  }
}
