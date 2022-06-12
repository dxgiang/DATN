import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/commons/themes/custom_theme.dart';

class OptionButton<T> extends StatelessWidget {
  final String? text;
  final Widget? child;
  final Color? backgroundColor;
  final double? height;
  final EdgeInsets? padding;
  final void Function(T?)? onTap;
  final void Function(T?)? onLongPress;
  final Widget? suffix;
  final Widget? prefix;
  final BorderRadius? borderRadius;
  final bool? hasBottomDivider;
  final T? value;
  final Border? border;

  const OptionButton({
    Key? key,
    this.text,
    this.child,
    this.backgroundColor,
    this.height,
    this.padding,
    this.onTap,
    this.onLongPress,
    this.suffix,
    this.prefix,
    this.borderRadius,
    this.hasBottomDivider = true,
    this.value,
    this.border,
  })  : assert(!(text == null && child == null)),
        super(key: key);

  factory OptionButton.first(
          {Widget? child,
          String? text,
          Color? backgroundColor,
          double? height,
          EdgeInsets? padding,
          Function(T?)? onTap,
          Function(T?)? onLongPress,
          Widget? suffix,
          Widget? prefix,
          Border? border,
          bool hasBottomDivider = true,
          T? value}) =>
      OptionButton<T>(
        text: text,
        child: child,
        backgroundColor: backgroundColor,
        height: height,
        padding: padding,
        onTap: onTap,
        onLongPress: onLongPress,
        suffix: suffix,
        prefix: prefix,
        value: value,
        hasBottomDivider: hasBottomDivider,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      );

  factory OptionButton.last(
          {Widget? child,
          String? text,
          Color? backgroundColor,
          double? height,
          EdgeInsets? padding,
          Function(T?)? onTap,
          Function(T?)? onLongPress,
          Widget? suffix,
          Widget? prefix,
          Border? border,
          T? value}) =>
      OptionButton<T>(
        child: child,
        text: text,
        backgroundColor: backgroundColor,
        height: height,
        padding: padding,
        onTap: onTap,
        onLongPress: onLongPress,
        suffix: suffix,
        prefix: prefix,
        value: value,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
        hasBottomDivider: false,
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? () => onTap?.call(value) : null,
      onLongPress: onLongPress != null ? () => onLongPress?.call(value) : null,
      child: Column(
        children: [
          Ink(
            height: height ?? 52.h,
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: border,
                color: backgroundColor ?? CustomTheme.colors(context).grey.o2),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  prefix != null
                      ? Padding(
                          padding: EdgeInsets.only(right: 8.w), child: prefix)
                      : Container(height: 0, width: 0),
                  Expanded(
                    child: child ??
                        Text(
                          text!,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontWeight: FontWeight.w700,
                                height: 1,
                              ),
                        ),
                  ),
                  suffix != null
                      ? Align(alignment: Alignment.centerLeft, child: suffix)
                      : Container(height: 0, width: 0),
                ],
              ),
            ),
          ),
          hasBottomDivider == true
              ? Divider(
                  height: 0, indent: 16.w, endIndent: 16.w, thickness: 1.2.h)
              : Container(width: 0, height: 0)
        ],
      ),
    );
  }

  OptionButton<T> copyWith({
    Key? key,
    String? text,
    Widget? child,
    Color? backgroundColor,
    double? height,
    EdgeInsets? padding,
    Function(T?)? onTap,
    Function(T?)? onLongPress,
    Widget? suffix,
    Widget? prefix,
    BorderRadius? borderRadius,
    bool? hasBottomDivider,
    T? value,
  }) {
    return OptionButton<T>(
      height: height ?? this.height,
      child: child ?? this.child,
      onLongPress: onLongPress ?? this.onLongPress,
      onTap: onTap ?? this.onTap,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      hasBottomDivider: hasBottomDivider ?? this.hasBottomDivider,
      key: key ?? this.key,
      prefix: prefix ?? this.prefix,
      suffix: suffix ?? this.suffix,
      text: text ?? this.text,
      value: value ?? this.value,
    );
  }

  OptionButton<T> merge(OptionButton<T>? other) {
    if (other == null) return this;
    return copyWith(
      key: other.key,
      text: other.text,
      child: other.child,
      backgroundColor: other.backgroundColor,
      height: other.height,
      padding: other.padding,
      onTap: other.onTap,
      onLongPress: other.onLongPress,
      suffix: other.suffix,
      prefix: other.prefix,
      borderRadius: other.borderRadius,
      hasBottomDivider: other.hasBottomDivider,
      value: other.value,
    );
  }

  static List<Widget> generate<T>(
      int length, OptionButton<T> builder(int index)) {
    return List.generate(length, (index) {
      OptionButton<T> child = builder(index);
      if (index == 0) {
        return child.merge(OptionButton.first(
          text: child.text,
          child: child.child,
        ));
      } else if (index == length - 1) {
        return child.merge(OptionButton.last(
          text: child.text,
          child: child.child,
        ));
      }
      return child;
    });
  }
}
