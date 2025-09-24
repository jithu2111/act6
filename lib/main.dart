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
      final next = (_counter + 1).clamp(0, 100);
      _counter = next;
      if (_counter == 100) {
        _showLiftoffDialog();
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter = (_counter - 1).clamp(0, 100);
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  Color _getCounterColor() {
    if (_counter == 0) {
      return const Color(0xFFE53935); // Red
    } else if (_counter > 50) {
      return const Color(0xFF43A047); // Green
    } else {
      return const Color(0xFFFFC107); // Yellow (1..50)
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

  Color _getNumberColor() {
    if (_counter == 0) {
      return const Color(0xFFE53935); // Red
    } else if (_counter > 50) {
      return const Color(0xFF43A047); // Green
    } else {
      return const Color(0xFFFFC107); // Yellow (for 1..50)
    }
  }

  void _showLiftoffDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 16,
          child: LiftoffAnimation(
            onClose: () {
              Navigator.of(dialogContext).pop();
              _resetCounter();
            },
          ),
        );
      },
    );
  }

  Widget _buildControlButton(String label, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemStatusCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'System Status',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatusIndicator(
                  'CRITICAL\n(0)',
                  const Color(0xFFE53935),
                  Icons.dangerous,
                ),
                _buildStatusIndicator(
                  'STANDBY\n(1-25)',
                  const Color(0xFFEF5350),
                  Icons.battery_1_bar,
                ),
                _buildStatusIndicator(
                  'INIT\n(26-50)',
                  const Color(0xFFFFC107),
                  Icons.battery_3_bar,
                ),
                _buildStatusIndicator(
                  'FUELING\n(51-75)',
                  const Color(0xFFFF9800),
                  Icons.warning_amber,
                ),
                _buildStatusIndicator(
                  'READY\n(76+)',
                  const Color(0xFF43A047),
                  Icons.rocket_launch,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String text, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 9,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    final Color statusColor = _getCounterColor();
    final Color numberColor = _getNumberColor();
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.rocket_launch, color: Colors.white),
            SizedBox(width: 8),
            Text('MISSION CONTROL', style: TextStyle(fontWeight: FontWeight.bold)),
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
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(
                    _getStatusIcon(),
                    size: 48,
                    color: statusColor,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _getStatusText(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$_counter',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: numberColor,
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _getCounterColor().withValues(alpha: 0.1),
                        _getCounterColor().withValues(alpha: 0.05),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _getCounterColor(),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: _getCounterColor().withValues(alpha: 0.3),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              _getStatusIcon(),
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getStatusText(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: _getCounterColor(),
                                ),
                              ),
                              Text(
                                'Power Level: $_counter%',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: _getCounterColor(),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: _getCounterColor().withValues(alpha: 0.3),
                              spreadRadius: 0,
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Text(
                          '$_counter',
                          style: const TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),


              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Launch Preparation Progress',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: _getCounterColor(),
                          inactiveTrackColor: Colors.grey[300],
                          thumbColor: _getCounterColor(),
                          overlayColor: _getCounterColor().withValues(alpha: 0.2),
                          valueIndicatorColor: _getCounterColor(),
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
                          trackHeight: 6,
                          disabledActiveTrackColor: _getCounterColor(),
                          disabledInactiveTrackColor: Colors.grey[300],
                          disabledThumbColor: _getCounterColor(),
                        ),
                        child: Slider(
                          min: 0,
                          max: 100,
                          value: _counter.toDouble(),
                          onChanged: null,
                          divisions: 100,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),


              // Control Buttons
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Mission Controls',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: _buildControlButton(
                              'IGNITE',
                              Icons.local_fire_department,
                              const Color(0xFF4CAF50),
                              _incrementCounter,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildControlButton(
                              'ABORT',
                              Icons.warning,
                              const Color(0xFFFF5722),
                              _decrementCounter,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildControlButton(
                              'RESET',
                              Icons.refresh,
                              const Color(0xFF2196F3),
                              _resetCounter,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // System Status Indicator
              _buildSystemStatusCard(),

              if (_counter == 100) ...[
                const SizedBox(height: 20),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.rocket_launch, color: Colors.white, size: 28),
                        const SizedBox(width: 12),
                        const Text(
                          'LAUNCH SEQUENCE READY!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}


class LiftoffAnimation extends StatefulWidget {
  final VoidCallback onClose;

  const LiftoffAnimation({super.key, required this.onClose});

  @override
  State<LiftoffAnimation> createState() => _LiftoffAnimationState();
}

class _LiftoffAnimationState extends State<LiftoffAnimation> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _flameAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );


    _slideAnim = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween(begin: const Offset(0, 0.6), end: const Offset(0, -0.25)).chain(CurveTween(curve: Curves.easeOut)),
        weight: 80,
      ),
      TweenSequenceItem(
        tween: Tween(begin: const Offset(0, -0.25), end: const Offset(0, -0.5)).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20,
      ),
    ]).animate(_controller);

    _scaleAnim = Tween<double>(begin: 0.9, end: 1.05)
        .chain(CurveTween(curve: Curves.easeOutBack))
        .animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6)));

    _flameAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1.0, curve: Curves.easeInOut)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildRocket(BuildContext context) {
    return SlideTransition(
      position: _slideAnim,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.rocket_launch,
                size: 52,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            AnimatedBuilder(
              animation: _flameAnim,
              builder: (context, child) {
                final flameHeight = 10.0 * _flameAnim.value;
                return Container(
                  width: 8,
                  height: flameHeight,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFC107), Color(0xFFFF5722)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1976D2),
            Color(0xFF0D47A1),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 130,
            child: Center(
              child: _buildRocket(context),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'LIFTOFF SUCCESSFUL!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Mission Status: ACCOMPLISHED',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your rocket has successfully reached orbit!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: widget.onClose,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF0D47A1),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
            ),
            child: const Text(
              'PREPARE NEXT MISSION',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}