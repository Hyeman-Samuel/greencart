import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:greencart_app/src/config/config.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 160,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, c) {
            return Transform.rotate(
              angle: -math.pi * 2 * _animation.value,
              child: CustomPaint(painter: _RotatingArcPainter()),
            );
          },
        ),
      ),
    );
  }
}

class _RotatingArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final centerOffset = Offset(width * 0.5, height * 0.5);
    canvas.translate(centerOffset.dx, centerOffset.dy);
    final outerDashPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.square
          ..shader = SweepGradient(
            colors: [
              AppColors.primary,
              AppColors.primary.withValues(alpha: 0.001),
            ],
          ).createShader(Rect.fromCircle(center: centerOffset, radius: 5))
          ..strokeWidth = 4;

    canvas.drawArc(
      Rect.fromCircle(center: centerOffset, radius: 26),
      0,
      math.pi * 1.96,
      false,
      outerDashPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
