import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: camel_case_types
class background_paint extends Container {
  background_paint(Widget _child)
      : super(
            decoration: const BoxDecoration(
                // ignore: unnecessary_const
                gradient:
                    const LinearGradient(colors: [Colors.blue, Colors.yellow])),
            child: _child);
}

// ignore: camel_case_types
class btn_textstyle extends TextStyle {
  const btn_textstyle(Color _text_color)
      : super(
          fontSize: 35,
          color: _text_color,
        );
}
