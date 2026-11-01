
import 'package:flutter/material.dart';

class PulseLineWidget extends StatefulWidget {
  const PulseLineWidget({
    super.key,
    this.width = 200,
    this.height = 56,
    this.activeColor = const Color(0xFFC8102E),
    this.inactiveColor = const Color(0xFFE5E9ED),
    this.strokeWidth = 2.8,
    this.duration = const Duration(milliseconds: 2400),
  });

  final double width;
  final double height;
  final Color activeColor;
  final Color inactiveColor;
  final double strokeWidth;
  final Duration duration;

  @override
  State<PulseLineWidget> createState() => _PulseLineWidgetState();
}

class _PulseLineWidgetState extends State<PulseLineWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _progress = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(
        painter: _PulsePainter(
          animation: _progress,
          activeColor: widget.activeColor,
          inactiveColor: widget.inactiveColor,
          strokeWidth: widget.strokeWidth,
        ),
      ),
    );
  }
}

class _PulsePainter extends CustomPainter {
  _PulsePainter({
    required this.animation,
    required this.activeColor,
    required this.inactiveColor,
    required this.strokeWidth,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color activeColor;
  final Color inactiveColor;
  final double strokeWidth;

  Path _createPath(Size size) {
    double x(double value) => size.width * value;
    double y(double value) => size.height * value;

    return Path()
      ..moveTo(x(0.04), y(0.55))
      ..lineTo(x(0.30), y(0.55))
      ..cubicTo(
        x(0.33), y(0.55),
        x(0.34), y(0.68),
        x(0.37), y(0.55),
      )
      ..cubicTo(
        x(0.39), y(0.43),
        x(0.41), y(0.48),
        x(0.43), y(0.55),
      )
      ..lineTo(x(0.49), y(0.55))
      ..lineTo(x(0.55), y(0.10))
      ..lineTo(x(0.60), y(0.85))
      ..lineTo(x(0.65), y(0.55))
      ..lineTo(x(0.72), y(0.55))
      ..cubicTo(
        x(0.75), y(0.55),
        x(0.76), y(0.38),
        x(0.79), y(0.48),
      )
      ..cubicTo(
        x(0.81), y(0.55),
        x(0.83), y(0.55),
        x(0.86), y(0.55),
      )
      ..lineTo(x(0.96), y(0.55));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final fullPath = _createPath(size);

    final inactivePaint = Paint()
      ..color = inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    final activePaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    // Draw the complete gray ECG track.
    canvas.drawPath(fullPath, inactivePaint);

    // Animate the red line from start to the very end.
    final metrics = fullPath.computeMetrics().toList();

    if (metrics.isEmpty) return;

    final metric = metrics.first;

    final animatedPath = metric.extractPath(
      0,
      metric.length * animation.value,
    );

    canvas.drawPath(animatedPath, activePaint);
  }

  @override
  bool shouldRepaint(covariant _PulsePainter oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.inactiveColor != inactiveColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
