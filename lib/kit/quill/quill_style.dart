import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tuple/tuple.dart';

DefaultStyles defaultStyles(BuildContext context) {
  final themeData = Theme.of(context);
  final defaultTextStyle = DefaultTextStyle.of(context);
  final baseStyle = defaultTextStyle.style.copyWith(
    fontSize: 16,
    height: 1.3,
    fontFamily: 'Microsoft Yahei',
    fontWeight: FontWeight.normal,
    color: const Color(0xFF555555),
    decoration: TextDecoration.none,
  );
  const baseSpacing = Tuple2<double, double>(6, 0);

  final inlineCodeStyle = TextStyle(
    fontSize: 14,
    color: Colors.deepPurple,
    fontFamily: 'Consolas',
  );

  return DefaultStyles(
      h1: DefaultTextBlockStyle(
          defaultTextStyle.style.copyWith(
            fontSize: 28,
            color: Colors.blue.shade900,
            height: 1.15,
            fontFamily: 'Microsoft Yahei',
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none,
          ),
          const Tuple2(16, 0),
          const Tuple2(0, 0),
          null),
      h2: DefaultTextBlockStyle(
          defaultTextStyle.style.copyWith(
            fontSize: 24,
            fontFamily: 'Microsoft Yahei',
            color: Colors.blue.shade900,
            height: 1.15,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
          ),
          const Tuple2(8, 0),
          const Tuple2(0, 0),
          null),
      h3: DefaultTextBlockStyle(
          defaultTextStyle.style.copyWith(
            fontSize: 20,
            fontFamily: 'Microsoft Yahei',
            color: Colors.blue.shade900,
            height: 1.25,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none,
          ),
          const Tuple2(8, 0),
          const Tuple2(0, 0),
          null),
      paragraph: DefaultTextBlockStyle(
          baseStyle, const Tuple2(8, 8), const Tuple2(0, 0), null),
      bold: const TextStyle(fontWeight: FontWeight.bold),
      italic: const TextStyle(fontStyle: FontStyle.italic),
      small: const TextStyle(fontSize: 12),
      underline: const TextStyle(decoration: TextDecoration.underline),
      strikeThrough: const TextStyle(decoration: TextDecoration.lineThrough),
      inlineCode: InlineCodeStyle(
        backgroundColor: Colors.grey.shade100,
        radius: const Radius.circular(3),
        style: inlineCodeStyle,
        header1: inlineCodeStyle.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w300,
        ),
        header2: inlineCodeStyle.copyWith(fontSize: 22),
        header3: inlineCodeStyle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      link: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
          decorationColor: Colors.blue.shade100),
      placeHolder: DefaultTextBlockStyle(
          defaultTextStyle.style.copyWith(
            fontSize: 20,
            height: 1.5,
            color: Colors.grey.withOpacity(0.6),
          ),
          const Tuple2(0, 0),
          const Tuple2(0, 0),
          null),
      lists: DefaultListBlockStyle(
          baseStyle, baseSpacing, const Tuple2(0, 6), null, null),
      quote: DefaultTextBlockStyle(
          TextStyle(color: baseStyle.color!.withOpacity(0.6)),
          baseSpacing,
          const Tuple2(6, 2),
          BoxDecoration(
            border: Border(
              left: BorderSide(width: 4, color: Colors.grey.shade300),
            ),
          )),
      code: DefaultTextBlockStyle(
          TextStyle(
            color: Colors.blue.shade900.withOpacity(0.9),
            fontFamily: 'Consolas',
            fontSize: 13,
            height: 1.15,
          ),
          baseSpacing,
          const Tuple2(0, 0),
          BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(2),
          )),
      indent: DefaultTextBlockStyle(
          baseStyle, baseSpacing, const Tuple2(0, 6), null),
      align: DefaultTextBlockStyle(
          baseStyle, const Tuple2(0, 0), const Tuple2(0, 0), null),
      leading: DefaultTextBlockStyle(
          baseStyle, const Tuple2(0, 0), const Tuple2(0, 0), null),
      sizeSmall: const TextStyle(fontSize: 10),
      sizeLarge: const TextStyle(fontSize: 18),
      sizeHuge: const TextStyle(fontSize: 22));
}
