import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';

import 'timer_notifier.dart';
import 'timer_state.dart';
import 'settings_notifier.dart';
import 'settings_state.dart';

final timerNotifierProvider = StateNotifierProvider<TimerNotifier, TimerState>((
  ref,
) {
  return TimerNotifier();
});

final settingsNotifierProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
      return SettingsNotifier();
    });

enum TimerMode { single, queue }

void main() {
  runApp(const ProviderScope(child: MyApp()));
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

class MyHomePage extends ConsumerStatefulWidget {
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
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _currentPageIndex = 0;

  void _onNavBarTap(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void _showTimePickerDialog(context) {
    final timerNotifier = ref.read(timerNotifierProvider.notifier);
    final currentDuration = ref.read(timerNotifierProvider).countdownRemaining;
    final List<Duration> queue = [];

    void pickNextDuration() {
      Duration selected = const Duration(minutes: 1);

      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: 300,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hm,
                  initialTimerDuration: currentDuration,
                  onTimerDurationChanged: (d) => selected = d,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CupertinoButton(
                    child: const Text('Add another'),
                    onPressed: () {
                      queue.add(selected);
                      Navigator.of(context).pop();
                      pickNextDuration();
                    },
                  ),
                  CupertinoButton(
                    child: Text("Done"),
                    onPressed: () {
                      queue.add(selected);
                      Navigator.of(context).pop();
                      if (queue.length == 1) {
                        timerNotifier.updateInitialDuration(selected);
                      } else {
                        timerNotifier.setTime(queue);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    pickNextDuration();
  }

  String _displayTimeRemainingFormatted(
    List<Duration> queue,
    Duration timeRemaining,
  ) {
    final parts = <String>[];

    final hours = timeRemaining.inHours;
    final minutes = timeRemaining.inMinutes % 60;
    final seconds = timeRemaining.inSeconds % 60;

    if ( hours > 0) {
      parts.add("${hours}h");
    }

    if (minutes > 0) {
      parts.add("${minutes}m");
    }

    if (seconds > 0) {
      parts.add("${seconds}s");
    }

    return parts.join(", ");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called

    final timerState = ref.watch(timerNotifierProvider);
    final timerNotifier = ref.read(timerNotifierProvider.notifier);
    final settingsState = ref.watch(settingsNotifierProvider);
    final settingsNotifier = ref.read(settingsNotifierProvider.notifier);

    List<Widget> pages = [
      _buildTimerPage(
        timerState,
        timerNotifier,
        settingsState,
        settingsNotifier,
      ),
      _buildSettingsPage(settingsState, settingsNotifier),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: _currentPageIndex == 0
            ? [
                MenuAnchor(
                  menuChildren: [
                    MenuItemButton(
                      onPressed: () => _showTimePickerDialog(context),
                      child: Text("Set Timer Duration"),
                    ),
                  ],
                  builder: (context, controller, child) => IconButton(
                    onPressed: controller.open,
                    icon: Icon(Icons.menu),
                  ),
                ),
              ]
            : [],
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
  Widget _buildTimerPage(
    timerState,
    timerNotifier,
    settingsState,
    settingsNotifier,
  ) {
    final minutes = timerState.countdownRemaining.inMinutes;
    final seconds = timerState.countdownRemaining.inSeconds % 60;


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // TODO: add total time visible here, format it to look prettier
        Text(
          _displayTimeRemainingFormatted(timerState.countdownQueue, timerState.countdownRemaining),
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          "Stopwatch: ${timerState.stopwatchElapsed.inSeconds}",
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 72,
              onPressed: () {
                timerNotifier.toggleTimers();
                settingsNotifier.handleTimerSettingsOnStart();
              },
              icon: Icon(timerState.currentIcon),
            ),
            SizedBox(width: 15),
            IconButton(
              iconSize: 72,
              onPressed: timerNotifier.resetTimers,
              icon: Icon(Icons.stop_circle),
            ),
          ],
        ),
      ],
    );
  }

  //Settings Page
  Widget _buildSettingsPage(state, notifier) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Settings Page :)",
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        CheckboxListTile(
          value: state.timerStartsDnD,
          onChanged: (bool? value) {
            notifier.toggleTimerSettings(
              TimerSetting.timerStartsDnD,
              !state.timerStartsDnD,
            );
          },
          title: Text("Turn on DnD with timer?"),
        ),
        CheckboxListTile(
          value: state.overrideSystemVolume,
          onChanged: (bool? value) {
            notifier.toggleTimerSettings(
              TimerSetting.overrideSystemVolume,
              !state.overrideSystemVolume,
            );
          },
          title: Text("Override system volume?"),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 4),
              child: Text("Volume Override Value:"),
            ),
            Slider(
              value: state.volumeOverrideValue,
              onChanged: (double value) =>
                  notifier.setVolumeOverrideValue(value),
              min: 0,
              max: 1,
              divisions: 100,
              label: "${((state.volumeOverrideValue * 100).toInt())}",
            ),
          ],
        ),
        CheckboxListTile(
          value: state.playSoundOnEachTimer,
          onChanged: (bool? value) {
            notifier.toggleTimerSettings(
              TimerSetting.playSoundOnEachTimer,
              !state.playSoundOnEachTimer,
            );
          },
          title: Text("Play sound for each timer?"),
        ),
        CheckboxListTile(
          value: state.silenceRinger,
          onChanged: (bool? value) {
            notifier.toggleTimerSettings(
              TimerSetting.silenceRinger,
              !state.silenceRinger,
            );
          },
          title: Text("Silence ringer with timer?"),
        ),
      ],
    );
  }
}
