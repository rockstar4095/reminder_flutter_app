import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Widget child;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const PrimaryButton({
    this.child,
    @required this.onPressed,
    this.padding,
    this.margin,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    Widget _child = text != null
        ? Text(
            text,
            style: TextStyle(color: Colors.white),
          )
        : child;

    return Container(
      width: double.infinity,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16),
      child: RaisedButton(
        padding: padding ?? const EdgeInsets.all(16),
        child: _child,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class AppTextButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderSide borderSide;

  const AppTextButton({
    this.child,
    @required this.onPressed,
    this.padding,
    this.margin,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 16),
        child: FlatButton(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderSide ?? BorderSide.none,
          ),
          splashColor: Theme.of(context).hintColor,
          highlightColor: Theme.of(context).primaryColorLight,
        ),
      );
}
