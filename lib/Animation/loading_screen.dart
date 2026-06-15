import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:innersky/screeens/main_screen/Home.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int _index = 0;
  bool _showAnimation = false;
  Timer? _imageTimer;

  final List<String> _images = List.generate(
    14,
    (i) => 'assets/loading_animation/${i + 1}.png',
  );

  final Duration frameTime = const Duration(milliseconds: 120);
  final Duration transitionTime = const Duration(milliseconds: 15);

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      setState(() {
        _showAnimation = true;
      });

      _imageTimer = Timer.periodic(frameTime, (_) {
        if (!mounted) return;

        setState(() {
          _index = (_index + 1) % _images.length;
        });
      });
    });

    Future.delayed(const Duration(milliseconds: 6200), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    for (final image in _images) {
      precacheImage(AssetImage(image), context);
    }
  }

  @override
  void dispose() {
    _imageTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final imageSize = min(screen.width, screen.height) * 0.15;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: _showAnimation
              ? SizedBox(
                  width: imageSize,
                  height: imageSize,
                  child: AnimatedSwitcher(
                    duration: transitionTime,
                    layoutBuilder: (currentChild, previousChildren) {
                      return currentChild ?? const SizedBox.shrink();
                    },
                    transitionBuilder: (child, animation) {
                      final curvedAnimation = CurvedAnimation(
                        parent: animation,
                        curve: const RiveEaseInCurve(
                          amplitude: 1,
                          period: 1,
                        ),
                      );

                      return FadeTransition(
                        opacity: curvedAnimation,
                        child: ScaleTransition(
                          scale: Tween<double>(
                            begin: 0.96,
                            end: 1.0,
                          ).animate(curvedAnimation),
                          child: child,
                        ),
                      );
                    },
                    child: Image.asset(
                      _images[_index],
                      key: ValueKey(_images[_index]),
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}

class EmptyNextScreen extends StatelessWidget {
  const EmptyNextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(),
    );
  }
}

class RiveEaseInCurve extends Curve {
  final double amplitude;
  final double period;

  const RiveEaseInCurve({
    this.amplitude = 1,
    this.period = 1,
  });

  @override
  double transformInternal(double t) {
    if (t == 0 || t == 1) return t;

    final double s = period / 4;

    return -amplitude *
        pow(2, 10 * (t - 1)) *
        sin(((t - 1) - s) * (2 * pi) / period);
  }
}
