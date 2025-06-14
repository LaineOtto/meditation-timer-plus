import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'timer/timer_notifier.dart';
import 'timer/timer_state.dart';
import 'settings/settings_notifier.dart';
import 'settings/settings_state.dart';
import 'settings/platform_settings_service.dart';
import 'timer/timer_utils.dart';

final timerNotifierProvider = StateNotifierProvider<TimerNotifier, TimerState>((
  ref,
) {
  return TimerNotifier();
});

final settingsNotifierProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
      final platformService = ref.read(platformServiceProvider);
      return SettingsNotifier(platformService);
    });

final platformServiceProvider = Provider<PlatformSettingsService>((ref) {
  return PlatformSettingsService();
});

// enum TimerMode { single, queue }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();

  final container = ProviderContainer();

  await container.read(settingsNotifierProvider.notifier).loadFromPrefs();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const ProviderScope(child: MyApp()),
    ),
  );
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

  void _showTimePickerDialog(context, queueString, bool isMultiple) {
    final timerNotifier = ref.read(timerNotifierProvider.notifier);
    final currentDuration = ref.read(timerNotifierProvider).countdownRemaining;
    final List<Duration> queue = [];
    final timerUtils = TimerUtils();

    List<Widget> buildButtons({
      required TimerMode timerMode,
      required Duration selected,
      required VoidCallback onAddAnother,
      required VoidCallback onDone,
    }) {
      List<Widget> buttons = [];
      if (timerMode == TimerMode.queue) {
        buttons.add(
          CupertinoButton(
            child: const Text('Add another'),
            onPressed: onAddAnother,
          ),
        );
      }
      buttons.add(
        CupertinoButton(child: const Text('Done'), onPressed: onDone),
      );
      return buttons;
    }

    void pickNextDuration() {
      Duration selected = const Duration(minutes: 1);

      showCupertinoModalPopup(
        context: context,
        builder: (_) => Material(
          child: Consumer(
            builder: (context, ref, child) {
              final timerState = ref.watch(timerNotifierProvider);

              void handleAddAnother() {
                queue.add(selected);
                Navigator.of(context).pop();
                pickNextDuration();
              }

              void handleDone() {
                queue.add(selected);
                Navigator.of(context).pop();
                if (queue.length == 1) {
                  timerNotifier.updateInitialDuration(selected);
                } else {
                  timerNotifier.setTime(queue);
                }
              }

              return Container(
                color: CupertinoColors.systemBackground.resolveFrom(context),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        timerUtils.formatQueueForDisplay(
                          timerState.countdownQueue,
                        ),
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                        softWrap: true,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      child: CupertinoTimerPicker(
                        mode: CupertinoTimerPickerMode.hm,
                        initialTimerDuration: currentDuration,
                        onTimerDurationChanged: (d) => selected = d,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: buildButtons(
                        timerMode: timerState.currentMode,
                        selected: selected,
                        onAddAnother: handleAddAnother,
                        onDone: handleDone,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }

    pickNextDuration();
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
                      onPressed: () => {
                        debugPrint("set queue false"),
                        _showTimePickerDialog(
                          context,
                          timerState.countdownQueue.toString(),
                          timerNotifier.setQueueMode(false),
                        ),
                      },
                      child: Text("Set Timer Duration"),
                    ),
                    MenuItemButton(
                      onPressed: () => {
                        print("set queue true"),
                        _showTimePickerDialog(
                          context,
                          timerState.countdownQueue.toString(),
                          timerNotifier.setQueueMode(true),
                        ),
                      },
                      child: Text("Set Multiple Durations"),
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
    final timerUtils = TimerUtils();
    final countdownInitial = timerState.countdownInitial.inSeconds;
    double countdownProgress =
        timerState.countdownRemaining.inSeconds / countdownInitial;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: CustomPaint(
            size: Size(200, 200),
            painter: TimerProgressPainter(progress: countdownProgress),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.alarm, size: 40),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 250,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        timerUtils
                                .displayTimeFormatted(
                                  timerState.countdownRemaining,
                                )
                                .isNotEmpty
                            ? timerUtils.displayTimeFormatted(
                                timerState.countdownRemaining,
                              )
                            : "Countdown Finished",
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontFeatures: [FontFeature.tabularFigures()],
                              fontFamily: 'monospace',
                            ),
                        textAlign: TextAlign.left,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.schedule, size: 40),
                SizedBox(width: 10),
                SizedBox(
                  width: 250,
                  child: Text(
                    timerState.countdownQueue.isNotEmpty
                      ? timerUtils.formatQueueForDisplay(
                          timerState.countdownQueue,
                        )
                      : "No Queue",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontFeatures: [FontFeature.tabularFigures()],
                      fontFamily: 'monospace',
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer_sharp, size: 40),
                SizedBox(width: 10),
                SizedBox(
                  width: 250,
                  child: Text(
                    timerUtils
                            .displayTimeFormatted(timerState.stopwatchElapsed)
                            .isNotEmpty
                        ? timerUtils.displayTimeFormatted(
                            timerState.stopwatchElapsed,
                          )
                        : "0s",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontFeatures: [FontFeature.tabularFigures()],
                      fontFamily: 'monospace',
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
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
          value: state.silenceRinger,
          onChanged: (bool? value) {
            notifier.toggleTimerSettings(
              TimerSetting.silenceRinger,
              !state.silenceRinger,
            );
          },
          title: Text("Silence ringer with timer?"),
        ),
        Divider(height: 1, thickness: 1, indent: 20, endIndent: 40),
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
      ],
    );
  }
}

class TimerProgressPainter extends CustomPainter {
  final double progress; //0.0 to 1.0

  TimerProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    final progressPaint = Paint()
      ..color = Colors.deepOrange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final startAngle = -pi / 2;
    double currentAngle = -2 * pi * progress;

    if (progress == double.infinity) {
      currentAngle = 2 * pi;
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      currentAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant TimerProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
