import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mission Control',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1976D2),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xFF0D47A1),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 8,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
      home: const CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  CounterWidgetState createState() => CounterWidgetState();
}

class CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      if (_counter < 100) {
        _counter++;
        if (_counter == 100) {
          // Will implement dialog in next commit
          print('Launch Ready!');
        }
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  // Added helper methods

  Color _getCounterColor() {
    if (_counter == 0) {
      return const Color(0xFFE53935); // Critical Red
    } else if (_counter > 75) {
      return const Color(0xFF43A047); // Launch Green
    } else if (_counter > 50) {
      return const Color(0xFFFF9800); // Warning Orange
    } else if (_counter > 25) {
      return const Color(0xFFFFC107); // Caution Yellow
    } else {
      return const Color(0xFFEF5350); // Low Red
    }
  }

  IconData _getStatusIcon() {
    if (_counter == 0) {
      return Icons.dangerous;
    } else if (_counter > 75) {
      return Icons.rocket_launch;
    } else if (_counter > 50) {
      return Icons.warning_amber;
    } else if (_counter > 25) {
      return Icons.battery_3_bar;
    } else {
      return Icons.battery_1_bar;
    }
  }

  String _getStatusText() {
    if (_counter == 0) {
      return 'SYSTEM OFFLINE';
    } else if (_counter == 100) {
      return 'LAUNCH READY';
    } else if (_counter > 75) {
      return 'PRE-LAUNCH';
    } else if (_counter > 50) {
      return 'FUELING';
    } else if (_counter > 25) {
      return 'INITIALIZING';
    } else {
      return 'STANDBY';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.rocket_launch, color: Colors.white),
            const SizedBox(width: 8),
            const Text(
              'MISSION CONTROL',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Status Display
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _getCounterColor().withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(
                    _getStatusIcon(),
                    size: 48,
                    color: _getCounterColor(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _getStatusText(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _getCounterColor(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$_counter',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: _getCounterColor(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _incrementCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                  ),
                  child: const Text('IGNITE'),
                ),
                ElevatedButton(
                  onPressed: _decrementCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5722),
                  ),
                  child: const Text('ABORT'),
                ),
                ElevatedButton(
                  onPressed: _resetCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                  ),
                  child: const Text('RESET'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
