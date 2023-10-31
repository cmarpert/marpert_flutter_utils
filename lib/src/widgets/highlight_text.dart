import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Creates a Text Widget that highlights a given text passage
///
/// Each match of [textToHighlight] in [text] can be highlighted with
/// an optional [highlightTextColor] and [highlightBackgroundColor]
///
/// The non-highlighted text can by styled as in a normal Text-Widget via the
/// [style] argument
///
/// [caseSensitive] defaults to 'true', but can be changed to 'false'
class HighlightText extends StatelessWidget {
  final String text;
  final String? textToHighlight;
  final TextStyle? style;
  final Color? highlightBackgroundColor;
  final Color? highlightTextColor;
  final bool caseSensitive;

  const HighlightText({
    super.key,
    required this.text,
    this.textToHighlight = '',
    this.style,
    this.highlightBackgroundColor,
    this.highlightTextColor,
    this.caseSensitive = true,
  });

  List<TextSpan> _getProcessedTextSpans() {
    final RegExp highlightRegex = RegExp(textToHighlight ?? '', caseSensitive: caseSensitive);
    var matches = highlightRegex.allMatches(text);

    List<TextSpan> spans = [];
    int start = 0;
    int i = -1;
    for (var match in matches) {
      i++;
      if (match.start > start) {
        // normal text before highlight
        spans.add(_normalSpan(text.substring(start, match.start)));
      }
      start = match.end;
      spans.add(_highlightSpan(text.substring(match.start, match.end)));
    }
    if (start < text.length) {
      // normal text after last highlight
      spans.add(_normalSpan(text.substring(start)));
    }

    return spans;
  }

  TextSpan _highlightSpan(String content) {
    return TextSpan(
      text: content,
      style: TextStyle(
        color: highlightTextColor,
        backgroundColor: highlightBackgroundColor,
      ),
    );
  }

  TextSpan _normalSpan(String content) {
    return TextSpan(text: content, style: style);
  }

  @override
  Widget build(BuildContext context) {
    if ((textToHighlight?.isEmpty ?? true) || text.isEmpty) {
      return Text(key: const Key('NormalText'), text, style: style);
    }

    final textSpans = _getProcessedTextSpans();
    return RichText(
      key: const Key('HighlightedText'),
      text: TextSpan(children: textSpans, style: style),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text));
    properties.add(StringProperty('textToHighlight', textToHighlight));
    properties.add(DiagnosticsProperty<TextStyle>('style', style));
    style?.debugFillProperties(properties);
    properties.add(ColorProperty('highlightBackgroundColor', highlightBackgroundColor));
    properties.add(ColorProperty('highlightTextColor', highlightTextColor));
    properties.add(DiagnosticsProperty<bool>('caseSensitive', caseSensitive));
  }
}
