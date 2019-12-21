import 'package:flutter/material.dart';

/// A simple animated [Text] widget, updates text with a cross fade transition.
class CrossFadeText extends StatefulWidget {
  /// Instantiate a [CrossFadeText] widget.
  ///
  /// Given the [text] to be rendered, an optional text [style] and [duration] of the transition.
  const CrossFadeText({
    Key key,
    this.text,
    this.style,
    this.duration = const Duration(milliseconds: 800),
  }) : super(key: key);

  final String text;
  final TextStyle style;
  final Duration duration;

  @override
  State<StatefulWidget> createState() => _CrossFadeTextState();
}

/// [State] of [CrossFadeText]
class _CrossFadeTextState extends State<CrossFadeText> {
  bool _showFirst;
  String _textFirst;
  String _textSecond;

  @override
  void initState() {
    super.initState();
    _showFirst = true;
    _textFirst = widget.text;
  }

  @override
  void didUpdateWidget(CrossFadeText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text) {
      if (_showFirst) {
        _textSecond = widget.text;
      } else {
        _textFirst = widget.text;
      }
      _showFirst = !_showFirst;
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedCrossFade(
    duration: widget.duration,
    firstChild: Text(_textFirst ?? '', style: widget.style),
    secondChild: Text(_textSecond ?? '', style: widget.style),
    crossFadeState: _showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
  );
}
