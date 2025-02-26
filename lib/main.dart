import 'package:flutter/material.dart';

/// Entry point of the Flutter application.
void main() {
  runApp(const MyApp());
}

/// A stateless widget that provides the root of the application.
class MyApp extends StatelessWidget {
  /// Creates an instance of [MyApp].
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Padding(
        padding: EdgeInsets.all(32.0),
        child: SquareAnimation(),
      ),
    );
  }
}

/// A widget that animates a red square between the left and right edges.
///
/// The square starts centered. When the "Right" button is pressed,
/// the square animates to the right edge over 1 second. When the "Left"
/// button is pressed, it animates to the left edge. Buttons are disabled
/// appropriately when the square is at an edge or during animation.
class SquareAnimation extends StatefulWidget {
  /// Creates a [SquareAnimation] widget.
  const SquareAnimation({super.key});

  @override
  SquareAnimationState createState() => SquareAnimationState();
}

/// State class for [SquareAnimation].
class SquareAnimationState extends State<SquareAnimation> {
  /// The size of the red square.
  static const double _squareSize = 50.0;

  /// The current alignment of the red square.
  Alignment _alignment = Alignment.center;

  /// Indicates whether an animation is currently in progress.
  bool _isAnimating = false;

  /// Moves the square to the left edge.
  void _moveLeft() {
    // Do nothing if already animating or if the square is at the left edge.
    if (_isAnimating || _alignment == Alignment.centerLeft) return;
    setState(() {
      _isAnimating = true;
      _alignment = Alignment.centerLeft;
    });
  }

  /// Moves the square to the right edge.
  void _moveRight() {
    // Do nothing if already animating or if the square is at the right edge.
    if (_isAnimating || _alignment == Alignment.centerRight) return;
    setState(() {
      _isAnimating = true;
      _alignment = Alignment.centerRight;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine whether the buttons should be disabled.
    final bool leftDisabled =
        _isAnimating || _alignment == Alignment.centerLeft;
    final bool rightDisabled =
        _isAnimating || _alignment == Alignment.centerRight;

    return Column(
      children: [
        // Expanded widget to allow the animation area to fill available space.
        Expanded(
          child: Container(
            width: double.infinity,
            // AnimatedAlign smoothly moves the square over a 1-second duration.
            child: AnimatedAlign(
              alignment: _alignment,
              duration: const Duration(seconds: 1),
              onEnd: () {
                setState(() {
                  _isAnimating = false;
                });
              },
              child: Container(
                width: _squareSize,
                height: _squareSize,
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Row of buttons to control square movement.
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: rightDisabled ? null : _moveRight,
              child: const Text('Right'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: leftDisabled ? null : _moveLeft,
              child: const Text('Left'),
            ),
          ],
        ),
      ],
    );
  }
}
