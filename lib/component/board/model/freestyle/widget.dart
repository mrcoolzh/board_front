import 'dart:math';

import 'package:flutter/material.dart';

import 'data.dart';

class MyCustomPainter extends CustomPainter {
  final FreeStyleModelData data;

  MyCustomPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    for (final path in data.pathList) {
      final paint = Paint()
        ..color = path.color
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 5.0;
      final points = path.points;
      for (int i = 0; i < points.length - 1; i++) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class FreeStyleWidget extends StatefulWidget {
  final FreeStyleModelData data;
  final bool editable;
  final ValueSetter<FreeStylePathModelData>? onDrawPath;
  const FreeStyleWidget({
    Key? key,
    required this.data,
    required this.editable,
    required this.onDrawPath,
  }) : super(key: key);

  @override
  State<FreeStyleWidget> createState() => _FreeStyleWidgetState();
}

class _FreeStyleWidgetState extends State<FreeStyleWidget> {
  @override
  Widget build(BuildContext context) {
    Widget child = CustomPaint(
      painter: MyCustomPainter(widget.data),
      size: Size.infinite,
    );
    child = ClipRect(
      child: child,
    );
    if (!widget.editable) return child;
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onPanStart: (d) {
        final pathList = widget.data.pathList;
        pathList.add(
          FreeStylePathModelData({
            'color': Color.fromARGB(
              255,
              Random().nextInt(256),
              Random().nextInt(256),
              Random().nextInt(256),
            ).value,
          }),
        );
        widget.data.pathList = pathList;
      },
      onPanUpdate: (d) {
        if (!context.size!.contains(d.localPosition)) return;
        // 绘制越界
        final points = widget.data.pathList.last.points;
        points.add(d.localPosition);
        widget.data.pathList.last.points = points;
        setState(() {});
      },
      onPanEnd: (d) {
        print('Add path: ${widget.data.pathList.last}');
        if (widget.onDrawPath != null) widget.onDrawPath!(widget.data.pathList.last);
      },
      child: child,
    );
  }
}
