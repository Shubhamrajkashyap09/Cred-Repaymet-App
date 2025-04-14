import 'dart:math';
import 'package:flutter/material.dart';

class CircularSlider extends StatefulWidget {
  final double min;
  final double max;
  final double value;
  final ValueChanged<double> onChanged;

  const CircularSlider({
    Key? key,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CircularSliderState createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSlider> {
  double _angle = 0.0;

  @override
  void initState() {
    super.initState();
    _angle = (widget.value / widget.max) * 2 * pi;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset localPosition = renderBox.globalToLocal(details.globalPosition);

        // Calculate angle
        _angle = atan2(localPosition.dy - renderBox.size.height / 2,
            localPosition.dx - renderBox.size.width / 2);

        // Normalize the angle between 0 and 2π
        if (_angle < 0) {
          _angle += 2 * pi;
        }

        // Calculate the new value
        double newValue =
            ((widget.max - widget.min) * (_angle / (2 * pi)) + widget.min)
                .clamp(widget.min, widget.max);
        widget.onChanged(newValue);
      },
      child: CustomPaint(
        size: Size(250, 250),
        painter: CircularSliderPainter(
          angle: _angle,
          min: widget.min,
          max: widget.max,
        ),
      ),
    );
  }
}

class CircularSliderPainter extends CustomPainter {
  final double angle;
  final double min;
  final double max;

  CircularSliderPainter(
      {required this.angle, required this.min, required this.max});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint trackPaint = Paint()
      ..color = Color.fromARGB(255, 243, 182, 182)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    //slider color
    final Paint progressPaint = Paint()
      ..color = Color.fromARGB(255, 112, 36, 1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    // slider line color
    final Paint pointerPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2 - 20,
      trackPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2 - 20),
      -pi / 2, // Start angle
      angle, // Sweep angle
      false,
      progressPaint,
    );

    // Calculate the position of the pointer
    double pointerX =
        (size.width / 2) + (size.width / 2 - 20) * cos(angle - pi / 2);
    double pointerY =
        (size.height / 2) + (size.width / 2 - 20) * sin(angle - pi / 2);

    //pointer
    canvas.drawCircle(
        Offset(pointerX, pointerY), 10, pointerPaint); // Pointer radius is 10
    canvas.drawCircle(Offset(pointerX, pointerY), 5, pointerPaint);
  }

  @override
  bool shouldRepaint(CircularSliderPainter oldDelegate) {
    return oldDelegate.angle != angle;
  }
}
