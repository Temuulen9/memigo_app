import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Button extends StatelessWidget {
  final String? text;
  final VoidCallback? onClick;
  final bool? isLoading;
  final bool? isDisabled;
  final Widget? icon;
  final IconData? iconData;
  final ButtonSizes size;
  final ButtonTypes? type;
  final Widget? suffixIcon;
  final bool? expanded;
  final bool? lead;
  final EdgeInsets? padding;
  final MainAxisAlignment? mainAxisAlignment;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Color? bgcolor;
  final TextStyle? textStyle;
  final Gradient? gradient;
  const Button({
    super.key,
    this.text,
    this.onClick,
    this.isLoading,
    this.isDisabled,
    this.icon,
    this.iconData,
    this.size = ButtonSizes.large,
    this.type = ButtonTypes.primary,
    this.suffixIcon,
    this.expanded = true,
    this.lead,
    this.padding,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.borderRadius,
    this.boxShadow,
    this.bgcolor,
    this.textStyle,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    double? height = buttonHeight[size];
    Color? bgColor = bgcolor ?? backgroundColor[type];

    return Material(
      borderRadius: BorderRadius.circular(10),
      color: bgColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: isDisabled == true || isLoading == true ? null : onClick,
        child: Ink(
          decoration: BoxDecoration(
            color: bgColor,
            gradient: bgcolor == null ? gradient : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: padding ?? (text != null ? const EdgeInsets.symmetric(horizontal: 24) : null),
            decoration: BoxDecoration(
              border: (type == ButtonTypes.secondary && isDisabled != true)
                  ? Border.all(
                      color: const Color(0xFF6C63FF),
                      width: 1,
                    )
                  : null,
              borderRadius: BorderRadius.circular(10),
            ),
            height: height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: mainAxisAlignment!,
              mainAxisSize: expanded == true ? MainAxisSize.max : MainAxisSize.min,
              children: [
                iconSection(context),
                if ((icon != null && text != null) || iconData != null) const SizedBox(width: 8),
                textSection(context, isLoading: isLoading ?? false),
                if (suffixIcon != null) suffixIcon!
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget iconSection(BuildContext context) {
    Map<ButtonTypes, Color> iconColor = {
      ButtonTypes.primary: Colors.white,
      ButtonTypes.secondary: Colors.white,
      ButtonTypes.tertiary: Colors.black,
    };
    Color color = isDisabled == true ? Colors.red : iconColor[type]!;

    if (isLoading == true) {
      return SpinKitFadingCircle(
        size: iconSize[size]!,
        color: Colors.white,
      );
    }

    if (iconData != null) {
      return Icon(
        iconData,
        size: iconSize[size],
        color: color,
      );
    }

    if (icon != null) {
      return icon!;
    }

    return const SizedBox.shrink();
  }

  Widget textSection(BuildContext context, {required bool isLoading}) {
    Map<ButtonTypes, Color> textColor = {
      ButtonTypes.primary: Colors.white,
      ButtonTypes.secondary: const Color(0xFF6C63FF),
      ButtonTypes.tertiary: Colors.black,
    };
    Color color = isDisabled == true ? Colors.red : textColor[type]!;

    return Text(
      isLoading ? '' : text ?? '',
      style: textStyle ??
          TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),

      // style: textStyle[size]?.copyWith(color: color),
    );
  }
}

const Map<ButtonSizes, double> buttonHeight = {
  ButtonSizes.small: 36,
  ButtonSizes.medium: 46,
  ButtonSizes.large: 52,
};
const Map<ButtonSizes, double> iconSize = {
  ButtonSizes.small: 20,
  ButtonSizes.medium: 22,
  ButtonSizes.large: 24,
};
// const Map<ButtonSizes, TextStyle> textStyle = {
//   ButtonSizes.small: TextStyles.buttonSmall,
//   ButtonSizes.medium: TextStyles.buttonMedium,
//   ButtonSizes.large: TextStyles.buttonLarge,
// };

Map<ButtonTypes, Color> backgroundColor = {
  ButtonTypes.primary: const Color(0xFF3632D5),
  ButtonTypes.secondary: const Color(0xFFFFFFFF),
  ButtonTypes.tertiary: const Color(0xFFF0F0F0),
};

enum ButtonSizes { small, medium, large }

enum ButtonTypes { primary, secondary, tertiary }
