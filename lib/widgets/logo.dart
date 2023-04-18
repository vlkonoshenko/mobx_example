import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              _Segment(quarterTurns: 4),
              _Segment(),
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              _Segment(quarterTurns: 3),
              _Segment(quarterTurns: 2),
            ],
          ),
        ),
      ],
    );
  }
}

class _Segment extends StatelessWidget {
  final int quarterTurns;
  const _Segment({this.quarterTurns = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RotatedBox(
          quarterTurns: quarterTurns,
          child: CustomPaint(painter: _LogoSegment())),
    );
  }
}

class _LogoSegment extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.5108696);
    path_0.cubicTo(size.width, size.height * 0.7810087, size.width * 0.7592696,
        size.height, size.width * 0.4891304, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.5108696);
    path_0.cubicTo(
        0,
        size.height * 0.2407300,
        size.width * 0.2189909,
        size.height * 0.02173913,
        size.width * 0.4891304,
        size.height * 0.02173913);
    path_0.cubicTo(size.width * 0.7592696, size.height * 0.02173913, size.width,
        size.height * 0.2407300, size.width, size.height * 0.5108696);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = const Color(0xff17CF97);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
