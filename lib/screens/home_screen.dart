import 'package:flutter/material.dart';

import '../state/hammer_state.dart';
import '../widgets/bonk_counter.dart';
import '../widgets/intensity_indicator.dart';
import '../widgets/mute_button.dart';
import '../widgets/rapid_combo_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final HammerState _state = HammerState();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _state.initialize();
    _state.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _state.resume();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _state.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _state.removeListener(_refresh);
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'HAMMERBONIA',
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w900, letterSpacing: 2),
                ),
                MuteButton(muted: _state.muted, onPressed: _state.toggleMute),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'Swing or shake your phone\nto hammer!',
              style: TextStyle(
                fontSize: 24,
                height: 1.1,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            Center(child: BonkCounter(count: _state.bonks)),
            const SizedBox(height: 44),
            IntensityIndicator(
              intensity: _state.intensity,
              label: _state.intensityLabel,
            ),
            const SizedBox(height: 24),
            Center(child: RapidComboIndicator(count: _state.rapidCount)),
            const Spacer(),
            const Center(
              child: Text(
                'Make some noise.',
                style: TextStyle(color: Color(0xFF8A8178)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
