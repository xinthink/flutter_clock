import 'package:flutter/material.dart';

/// A simple animated [Icon] widget, updates [IconData] with a cross fade transition.
class CrossFadeIcon extends StatefulWidget {
  /// Instantiate a [CrossFadeIcon] widget.
  ///
  /// Given the [icon] to be rendered, optional [size] and [color] of the [icon],
  /// and [duration] of the transition.
  const CrossFadeIcon({
    Key key,
    this.icon,
    this.size = 16,
    this.color = Colors.black,
    this.duration = const Duration(milliseconds: 800),
  }) : super(key: key);

  final IconData icon;
  final double size;
  final Color color;
  final Duration duration;

  @override
  State<StatefulWidget> createState() => _CrossFadeTextState();
}

/// [State] of [CrossFadeIcon]
class _CrossFadeTextState extends State<CrossFadeIcon> {
  bool _showFirst;
  IconData _iconFirst;
  IconData _iconSecond;

  @override
  void initState() {
    super.initState();
    _showFirst = true;
    _iconFirst = widget.icon;
  }

  @override
  void didUpdateWidget(CrossFadeIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.icon != oldWidget.icon) {
      if (_showFirst) {
        _iconSecond = widget.icon;
      } else {
        _iconFirst = widget.icon;
      }
      _showFirst = !_showFirst;
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedCrossFade(
    duration: widget.duration,
    firstChild: _iconFirst != null ? Icon(_iconFirst, size: widget.size, color: widget.color) : SizedBox(),
    secondChild: _iconSecond != null ? Icon(_iconSecond, size: widget.size, color: widget.color) : SizedBox(),
    crossFadeState: _showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
  );
}
