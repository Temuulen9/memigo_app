// import "package:flutter/material.dart";

// class MaterialTheme {
//   final TextTheme textTheme;

//   const MaterialTheme(this.textTheme);

//   static ColorScheme lightScheme() {
//     return const ColorScheme(
//       brightness: Brightness.light,
//       primary: Color(0xff006874),
//       surfaceTint: Color(0xff006874),
//       onPrimary: Color(0xffffffff),
//       primaryContainer: Color(0xff9eeffd),
//       onPrimaryContainer: Color(0xff001f24),
//       secondary: Color(0xff4a6267),
//       onSecondary: Color(0xffffffff),
//       secondaryContainer: Color(0xffcde7ec),
//       onSecondaryContainer: Color(0xff051f23),
//       tertiary: Color(0xff525e7d),
//       onTertiary: Color(0xffffffff),
//       tertiaryContainer: Color(0xffdae2ff),
//       onTertiaryContainer: Color(0xff0e1b37),
//       error: Color(0xffba1a1a),
//       onError: Color(0xffffffff),
//       errorContainer: Color(0xffffdad6),
//       onErrorContainer: Color(0xff410002),
//       surface: Color(0xfff5fafb),
//       onSurface: Color(0xff171d1e),
//       onSurfaceVariant: Color(0xff3f484a),
//       outline: Color(0xff6f797a),
//       outlineVariant: Color(0xffbfc8ca),
//       shadow: Color(0xff000000),
//       scrim: Color(0xff000000),
//       inverseSurface: Color(0xff2b3133),
//       inversePrimary: Color(0xff82d3e0),
//       primaryFixed: Color(0xff9eeffd),
//       onPrimaryFixed: Color(0xff001f24),
//       primaryFixedDim: Color(0xff82d3e0),
//       onPrimaryFixedVariant: Color(0xff004f58),
//       secondaryFixed: Color(0xffcde7ec),
//       onSecondaryFixed: Color(0xff051f23),
//       secondaryFixedDim: Color(0xffb1cbd0),
//       onSecondaryFixedVariant: Color(0xff334b4f),
//       tertiaryFixed: Color(0xffdae2ff),
//       onTertiaryFixed: Color(0xff0e1b37),
//       tertiaryFixedDim: Color(0xffbac6ea),
//       onTertiaryFixedVariant: Color(0xff3b4664),
//       surfaceDim: Color(0xffd5dbdc),
//       surfaceBright: Color(0xfff5fafb),
//       surfaceContainerLowest: Color(0xffffffff),
//       surfaceContainerLow: Color(0xffeff5f6),
//       surfaceContainer: Color(0xffe9eff0),
//       surfaceContainerHigh: Color(0xffe3e9ea),
//       surfaceContainerHighest: Color(0xffdee3e5),
//     );
//   }

//   ThemeData light() {
//     return theme(lightScheme());
//   }

//   static ColorScheme lightMediumContrastScheme() {
//     return const ColorScheme(
//       brightness: Brightness.light,
//       primary: Color(0xff004a53),
//       surfaceTint: Color(0xff006874),
//       onPrimary: Color(0xffffffff),
//       primaryContainer: Color(0xff25808c),
//       onPrimaryContainer: Color(0xffffffff),
//       secondary: Color(0xff2f474b),
//       onSecondary: Color(0xffffffff),
//       secondaryContainer: Color(0xff60797d),
//       onSecondaryContainer: Color(0xffffffff),
//       tertiary: Color(0xff374260),
//       onTertiary: Color(0xffffffff),
//       tertiaryContainer: Color(0xff687495),
//       onTertiaryContainer: Color(0xffffffff),
//       error: Color(0xff8c0009),
//       onError: Color(0xffffffff),
//       errorContainer: Color(0xffda342e),
//       onErrorContainer: Color(0xffffffff),
//       surface: Color(0xfff5fafb),
//       onSurface: Color(0xff171d1e),
//       onSurfaceVariant: Color(0xff3b4446),
//       outline: Color(0xff576162),
//       outlineVariant: Color(0xff737c7e),
//       shadow: Color(0xff000000),
//       scrim: Color(0xff000000),
//       inverseSurface: Color(0xff2b3133),
//       inversePrimary: Color(0xff82d3e0),
//       primaryFixed: Color(0xff25808c),
//       onPrimaryFixed: Color(0xffffffff),
//       primaryFixedDim: Color(0xff006671),
//       onPrimaryFixedVariant: Color(0xffffffff),
//       secondaryFixed: Color(0xff60797d),
//       onSecondaryFixed: Color(0xffffffff),
//       secondaryFixedDim: Color(0xff486064),
//       onSecondaryFixedVariant: Color(0xffffffff),
//       tertiaryFixed: Color(0xff687495),
//       onTertiaryFixed: Color(0xffffffff),
//       tertiaryFixedDim: Color(0xff505b7b),
//       onTertiaryFixedVariant: Color(0xffffffff),
//       surfaceDim: Color(0xffd5dbdc),
//       surfaceBright: Color(0xfff5fafb),
//       surfaceContainerLowest: Color(0xffffffff),
//       surfaceContainerLow: Color(0xffeff5f6),
//       surfaceContainer: Color(0xffe9eff0),
//       surfaceContainerHigh: Color(0xffe3e9ea),
//       surfaceContainerHighest: Color(0xffdee3e5),
//     );
//   }

//   ThemeData lightMediumContrast() {
//     return theme(lightMediumContrastScheme());
//   }

//   static ColorScheme lightHighContrastScheme() {
//     return const ColorScheme(
//       brightness: Brightness.light,
//       primary: Color(0xff00272c),
//       surfaceTint: Color(0xff006874),
//       onPrimary: Color(0xffffffff),
//       primaryContainer: Color(0xff004a53),
//       onPrimaryContainer: Color(0xffffffff),
//       secondary: Color(0xff0c2629),
//       onSecondary: Color(0xffffffff),
//       secondaryContainer: Color(0xff2f474b),
//       onSecondaryContainer: Color(0xffffffff),
//       tertiary: Color(0xff15213e),
//       onTertiary: Color(0xffffffff),
//       tertiaryContainer: Color(0xff374260),
//       onTertiaryContainer: Color(0xffffffff),
//       error: Color(0xff4e0002),
//       onError: Color(0xffffffff),
//       errorContainer: Color(0xff8c0009),
//       onErrorContainer: Color(0xffffffff),
//       surface: Color(0xfff5fafb),
//       onSurface: Color(0xff000000),
//       onSurfaceVariant: Color(0xff1c2527),
//       outline: Color(0xff3b4446),
//       outlineVariant: Color(0xff3b4446),
//       shadow: Color(0xff000000),
//       scrim: Color(0xff000000),
//       inverseSurface: Color(0xff2b3133),
//       inversePrimary: Color(0xffbff5ff),
//       primaryFixed: Color(0xff004a53),
//       onPrimaryFixed: Color(0xffffffff),
//       primaryFixedDim: Color(0xff003238),
//       onPrimaryFixedVariant: Color(0xffffffff),
//       secondaryFixed: Color(0xff2f474b),
//       onSecondaryFixed: Color(0xffffffff),
//       secondaryFixedDim: Color(0xff183034),
//       onSecondaryFixedVariant: Color(0xffffffff),
//       tertiaryFixed: Color(0xff374260),
//       onTertiaryFixed: Color(0xffffffff),
//       tertiaryFixedDim: Color(0xff202c49),
//       onTertiaryFixedVariant: Color(0xffffffff),
//       surfaceDim: Color(0xffd5dbdc),
//       surfaceBright: Color(0xfff5fafb),
//       surfaceContainerLowest: Color(0xffffffff),
//       surfaceContainerLow: Color(0xffeff5f6),
//       surfaceContainer: Color(0xffe9eff0),
//       surfaceContainerHigh: Color(0xffe3e9ea),
//       surfaceContainerHighest: Color(0xffdee3e5),
//     );
//   }

//   ThemeData lightHighContrast() {
//     return theme(lightHighContrastScheme());
//   }

//   static ColorScheme darkScheme() {
//     return const ColorScheme(
//       brightness: Brightness.dark,
//       primary: Color(0xff82d3e0),
//       surfaceTint: Color(0xff82d3e0),
//       onPrimary: Color(0xff00363d),
//       primaryContainer: Color(0xff004f58),
//       onPrimaryContainer: Color(0xff9eeffd),
//       secondary: Color(0xffb1cbd0),
//       onSecondary: Color(0xff1c3438),
//       secondaryContainer: Color(0xff334b4f),
//       onSecondaryContainer: Color(0xffcde7ec),
//       tertiary: Color(0xffbac6ea),
//       onTertiary: Color(0xff24304d),
//       tertiaryContainer: Color(0xff3b4664),
//       onTertiaryContainer: Color(0xffdae2ff),
//       error: Color(0xffffb4ab),
//       onError: Color(0xff690005),
//       errorContainer: Color(0xff93000a),
//       onErrorContainer: Color(0xffffdad6),
//       surface: Color(0xff0e1415),
//       onSurface: Color(0xffdee3e5),
//       onSurfaceVariant: Color(0xffbfc8ca),
//       outline: Color(0xff899294),
//       outlineVariant: Color(0xff3f484a),
//       shadow: Color(0xff000000),
//       scrim: Color(0xff000000),
//       inverseSurface: Color(0xffdee3e5),
//       inversePrimary: Color(0xff006874),
//       primaryFixed: Color(0xff9eeffd),
//       onPrimaryFixed: Color(0xff001f24),
//       primaryFixedDim: Color(0xff82d3e0),
//       onPrimaryFixedVariant: Color(0xff004f58),
//       secondaryFixed: Color(0xffcde7ec),
//       onSecondaryFixed: Color(0xff051f23),
//       secondaryFixedDim: Color(0xffb1cbd0),
//       onSecondaryFixedVariant: Color(0xff334b4f),
//       tertiaryFixed: Color(0xffdae2ff),
//       onTertiaryFixed: Color(0xff0e1b37),
//       tertiaryFixedDim: Color(0xffbac6ea),
//       onTertiaryFixedVariant: Color(0xff3b4664),
//       surfaceDim: Color(0xff0e1415),
//       surfaceBright: Color(0xff343a3b),
//       surfaceContainerLowest: Color(0xff090f10),
//       surfaceContainerLow: Color(0xff171d1e),
//       surfaceContainer: Color(0xff1b2122),
//       surfaceContainerHigh: Color(0xff252b2c),
//       surfaceContainerHighest: Color(0xff303637),
//     );
//   }

//   ThemeData dark() {
//     return theme(darkScheme());
//   }

//   static ColorScheme darkMediumContrastScheme() {
//     return const ColorScheme(
//       brightness: Brightness.dark,
//       primary: Color(0xff86d7e5),
//       surfaceTint: Color(0xff82d3e0),
//       onPrimary: Color(0xff001a1d),
//       primaryContainer: Color(0xff499ca9),
//       onPrimaryContainer: Color(0xff000000),
//       secondary: Color(0xffb5cfd4),
//       onSecondary: Color(0xff011a1d),
//       secondaryContainer: Color(0xff7c959a),
//       onSecondaryContainer: Color(0xff000000),
//       tertiary: Color(0xffbecaef),
//       onTertiary: Color(0xff081531),
//       tertiaryContainer: Color(0xff8490b2),
//       onTertiaryContainer: Color(0xff000000),
//       error: Color(0xffffbab1),
//       onError: Color(0xff370001),
//       errorContainer: Color(0xffff5449),
//       onErrorContainer: Color(0xff000000),
//       surface: Color(0xff0e1415),
//       onSurface: Color(0xfff6fcfd),
//       onSurfaceVariant: Color(0xffc3ccce),
//       outline: Color(0xff9ba5a6),
//       outlineVariant: Color(0xff7b8587),
//       shadow: Color(0xff000000),
//       scrim: Color(0xff000000),
//       inverseSurface: Color(0xffdee3e5),
//       inversePrimary: Color(0xff005059),
//       primaryFixed: Color(0xff9eeffd),
//       onPrimaryFixed: Color(0xff001417),
//       primaryFixedDim: Color(0xff82d3e0),
//       onPrimaryFixedVariant: Color(0xff003c44),
//       secondaryFixed: Color(0xffcde7ec),
//       onSecondaryFixed: Color(0xff001417),
//       secondaryFixedDim: Color(0xffb1cbd0),
//       onSecondaryFixedVariant: Color(0xff223a3e),
//       tertiaryFixed: Color(0xffdae2ff),
//       onTertiaryFixed: Color(0xff03102c),
//       tertiaryFixedDim: Color(0xffbac6ea),
//       onTertiaryFixedVariant: Color(0xff2a3553),
//       surfaceDim: Color(0xff0e1415),
//       surfaceBright: Color(0xff343a3b),
//       surfaceContainerLowest: Color(0xff090f10),
//       surfaceContainerLow: Color(0xff171d1e),
//       surfaceContainer: Color(0xff1b2122),
//       surfaceContainerHigh: Color(0xff252b2c),
//       surfaceContainerHighest: Color(0xff303637),
//     );
//   }

//   ThemeData darkMediumContrast() {
//     return theme(darkMediumContrastScheme());
//   }

//   static ColorScheme darkHighContrastScheme() {
//     return const ColorScheme(
//       brightness: Brightness.dark,
//       primary: Color(0xfff1fdff),
//       surfaceTint: Color(0xff82d3e0),
//       onPrimary: Color(0xff000000),
//       primaryContainer: Color(0xff86d7e5),
//       onPrimaryContainer: Color(0xff000000),
//       secondary: Color(0xfff1fdff),
//       onSecondary: Color(0xff000000),
//       secondaryContainer: Color(0xffb5cfd4),
//       onSecondaryContainer: Color(0xff000000),
//       tertiary: Color(0xfffcfaff),
//       onTertiary: Color(0xff000000),
//       tertiaryContainer: Color(0xffbecaef),
//       onTertiaryContainer: Color(0xff000000),
//       error: Color(0xfffff9f9),
//       onError: Color(0xff000000),
//       errorContainer: Color(0xffffbab1),
//       onErrorContainer: Color(0xff000000),
//       surface: Color(0xff0e1415),
//       onSurface: Color(0xffffffff),
//       onSurfaceVariant: Color(0xfff3fcfe),
//       outline: Color(0xffc3ccce),
//       outlineVariant: Color(0xffc3ccce),
//       shadow: Color(0xff000000),
//       scrim: Color(0xff000000),
//       inverseSurface: Color(0xffdee3e5),
//       inversePrimary: Color(0xff002f35),
//       primaryFixed: Color(0xffaaf3ff),
//       onPrimaryFixed: Color(0xff000000),
//       primaryFixedDim: Color(0xff86d7e5),
//       onPrimaryFixedVariant: Color(0xff001a1d),
//       secondaryFixed: Color(0xffd1ecf0),
//       onSecondaryFixed: Color(0xff000000),
//       secondaryFixedDim: Color(0xffb5cfd4),
//       onSecondaryFixedVariant: Color(0xff011a1d),
//       tertiaryFixed: Color(0xffe0e6ff),
//       onTertiaryFixed: Color(0xff000000),
//       tertiaryFixedDim: Color(0xffbecaef),
//       onTertiaryFixedVariant: Color(0xff081531),
//       surfaceDim: Color(0xff0e1415),
//       surfaceBright: Color(0xff343a3b),
//       surfaceContainerLowest: Color(0xff090f10),
//       surfaceContainerLow: Color(0xff171d1e),
//       surfaceContainer: Color(0xff1b2122),
//       surfaceContainerHigh: Color(0xff252b2c),
//       surfaceContainerHighest: Color(0xff303637),
//     );
//   }

//   ThemeData darkHighContrast() {
//     return theme(darkHighContrastScheme());
//   }

//   ThemeData theme(ColorScheme colorScheme) => ThemeData(
//         useMaterial3: true,
//         brightness: colorScheme.brightness,
//         colorScheme: colorScheme,
//         textTheme: textTheme.apply(
//           bodyColor: colorScheme.onSurface,
//           displayColor: colorScheme.onSurface,
//         ),
//         scaffoldBackgroundColor: colorScheme.surface,
//         canvasColor: colorScheme.surface,
//       );

//   /// Custom Color 1
//   static const customColor1 = ExtendedColor(
//     seed: Color(0xffba7fac),
//     value: Color(0xffba7fac),
//     light: ColorFamily(
//       color: Color(0xff824c77),
//       onColor: Color(0xffffffff),
//       colorContainer: Color(0xffffd7f2),
//       onColorContainer: Color(0xff350830),
//     ),
//     lightMediumContrast: ColorFamily(
//       color: Color(0xff824c77),
//       onColor: Color(0xffffffff),
//       colorContainer: Color(0xffffd7f2),
//       onColorContainer: Color(0xff350830),
//     ),
//     lightHighContrast: ColorFamily(
//       color: Color(0xff824c77),
//       onColor: Color(0xffffffff),
//       colorContainer: Color(0xffffd7f2),
//       onColorContainer: Color(0xff350830),
//     ),
//     dark: ColorFamily(
//       color: Color(0xfff4b2e3),
//       onColor: Color(0xff4d1f46),
//       colorContainer: Color(0xff67355e),
//       onColorContainer: Color(0xffffd7f2),
//     ),
//     darkMediumContrast: ColorFamily(
//       color: Color(0xfff4b2e3),
//       onColor: Color(0xff4d1f46),
//       colorContainer: Color(0xff67355e),
//       onColorContainer: Color(0xffffd7f2),
//     ),
//     darkHighContrast: ColorFamily(
//       color: Color(0xfff4b2e3),
//       onColor: Color(0xff4d1f46),
//       colorContainer: Color(0xff67355e),
//       onColorContainer: Color(0xffffd7f2),
//     ),
//   );

//   List<ExtendedColor> get extendedColors => [
//         customColor1,
//       ];
// }

// class ExtendedColor {
//   final Color seed, value;
//   final ColorFamily light;
//   final ColorFamily lightHighContrast;
//   final ColorFamily lightMediumContrast;
//   final ColorFamily dark;
//   final ColorFamily darkHighContrast;
//   final ColorFamily darkMediumContrast;

//   const ExtendedColor({
//     required this.seed,
//     required this.value,
//     required this.light,
//     required this.lightHighContrast,
//     required this.lightMediumContrast,
//     required this.dark,
//     required this.darkHighContrast,
//     required this.darkMediumContrast,
//   });
// }

// class ColorFamily {
//   const ColorFamily({
//     required this.color,
//     required this.onColor,
//     required this.colorContainer,
//     required this.onColorContainer,
//   });

//   final Color color;
//   final Color onColor;
//   final Color colorContainer;
//   final Color onColorContainer;
// }
