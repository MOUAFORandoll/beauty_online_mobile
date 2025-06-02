import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readmore/readmore.dart';
import 'package:beauty/common/widgets/read_more_theme.dart';
import 'package:beauty/common/utils/assets.dart';

abstract class AppTheme {
  static const Color primaryYellow =
      Color.fromARGB(255, 236, 64, 122); // Color(0xFFFFCC33);
  static const Color darkSecondary = Color(0xFFE5C36C);

  static const Color primaryBlack = Color(0xFF090909);
  static const Color primaryRed = Color(0xFFE30613);
  static const Color tertiaryContainer = Color(0xFFFFDAD5);
  static const Color onTertiaryContainer = Color(0xFF3B0906);
  static const Color onPrimary = Color(0xFF090909);
  static const Color onSurface = Color(0xFF16130B);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color surfaceGrey = Color(0xFFD9D9D9);
  static const Color errorRed = Color(0xFFFF0717);
  static const Color green = Color(0xFF00F57A);
  static const Color onHighGreen = Color(0xFF002914);
  static const Color midOrange = Color(0xFFFF7A00);
  static const Color onMidOrange = Color(0xFF331400);
  static const Color lowRed = Color(0xFFFF0717);

  static const Color mainText = Colors.white; // Colors.black;
  static const Color disabledText = Color(0xFF9F9F9F);

  static TextTheme _textTheme(BuildContext context) {
    final arco =
        Theme.of(context).textTheme.apply(fontFamily: Assets.fontsFamilyARCO);
    final jakarta = Theme.of(context)
        .textTheme
        .apply(fontFamily: Assets.fontsPlusJakartaSans);

    return jakarta.copyWith(
      displayLarge: jakarta.displayLarge?.copyWith(
        color: black,
        fontSize: 57.0,
      ),
      displayMedium: jakarta.displayMedium?.copyWith(
        color: black,
        fontSize: 45.0,
      ),
      displaySmall: arco.displaySmall?.copyWith(
        color: black,
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: jakarta.headlineLarge?.copyWith(
        color: black,
        fontSize: 32.0,
      ),
      headlineMedium: jakarta.headlineMedium?.copyWith(
        color: black,
        fontSize: 28.0,
      ),
      headlineSmall: jakarta.headlineSmall?.copyWith(
        color: black,
        fontSize: 24.0,
      ),
      titleLarge: arco.titleLarge?.copyWith(
        color: black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: jakarta.titleMedium?.copyWith(
        color: black,
        fontSize: 16.0,
      ),
      titleSmall: jakarta.titleSmall?.copyWith(
        color: black,
        fontSize: 14.0,
      ),
      bodyLarge: jakarta.bodyLarge
          ?.copyWith(color: black, fontSize: 16.0, fontWeight: FontWeight.bold),
      bodyMedium: jakarta.bodyMedium?.copyWith(
        color: black,
        fontSize: 14.0,
      ),
      bodySmall: jakarta.bodySmall?.copyWith(
        color: black,
        fontSize: 12.0,
      ),
      labelLarge: arco.labelLarge?.copyWith(
        color: black,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: jakarta.labelMedium?.copyWith(
        color: black,
        fontSize: 12.0,
      ),
      labelSmall: jakarta.labelSmall?.copyWith(
        color: black,
        fontSize: 11.0,
      ),
    );
  }

  static ColorScheme _colorScheme([Brightness brightness = Brightness.light]) {
    return ColorScheme.fromSeed(
      seedColor: primaryYellow,
      primary: primaryYellow,
      // secondary: primaryYellow,
      tertiary: primaryRed,
      onTertiaryContainer: onTertiaryContainer,
      tertiaryContainer: tertiaryContainer,
      error: errorRed,
      errorContainer: errorRed,
      brightness: brightness,
      onPrimary: onPrimary,
    );
  }

  static readMoreThemeData(BuildContext context) {
    final theme = Theme.of(context);
    return ReadMoreThemeData(
      trimMode: TrimMode.Line,
      trimCollapsedText: 'lire plus',
      trimExpandedText: 'moins',
      lessStyle: TextStyle(
          color: switch (theme.brightness) {
            Brightness.light => AppTheme.disabledText,
            Brightness.dark => AppTheme.white,
          },
          fontWeight: FontWeight.bold),
      moreStyle: TextStyle(
          color: switch (theme.brightness) {
            Brightness.light => AppTheme.disabledText,
            Brightness.dark => AppTheme.white,
          },
          fontWeight: FontWeight.bold),
    );
  }

  static ThemeData _baseTheme(BuildContext context, Brightness brightness) {
    final colorScheme = _colorScheme(brightness);
    final textTheme = _textTheme(context);
    final theme = Theme.of(context).copyWith(textTheme: textTheme);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      primaryColor: primaryYellow,
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.4),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryYellow,
      ),
      bottomSheetTheme: theme.bottomSheetTheme.copyWith(
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.0))),
      ),
      cardTheme: theme.cardTheme.copyWith(
        color: theme.colorScheme.surface,
        margin: EdgeInsets.zero,
        elevation: 1,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      checkboxTheme: theme.checkboxTheme.copyWith(
        checkColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected) ? white : null),
        fillColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? primaryYellow : null),
      ),
      dividerColor: theme.colorScheme.onSurfaceVariant,
      dividerTheme: theme.dividerTheme.copyWith(thickness: 0.2),
      dialogTheme: DialogTheme(contentTextStyle: textTheme.bodyLarge),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.circular(100.0)),
          elevation: 0,
          side: BorderSide.none,
          textStyle: textTheme.labelMedium,
          maximumSize: const Size.fromHeight(40.0),
        ),
      ),
      progressIndicatorTheme:
          ProgressIndicatorThemeData(borderRadius: BorderRadius.circular(32.0)),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.surfaceTint;
          }
          return Theme.of(context).colorScheme.onSurface;
        }),
      ),
      textButtonTheme: TextButtonThemeData(),
      tabBarTheme: TabBarTheme(
        labelStyle: textTheme.labelLarge?.copyWith(fontSize: 12),
        unselectedLabelStyle: textTheme.labelLarge?.copyWith(fontSize: 12),
        dividerHeight: 0,
        indicatorSize: TabBarIndicatorSize.label,
        tabAlignment: TabAlignment.start,
      ),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: colorScheme.surfaceContainerHighest,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          )),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            foregroundColor: colorScheme.onSurfaceVariant,
            side: BorderSide(color: colorScheme.onSurfaceVariant, width: 2.0)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryYellow,
          foregroundColor: mainText,
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.circular(100.0)),
          elevation: 0,
          side: BorderSide.none,
          textStyle: textTheme.labelLarge!.copyWith(color: mainText),
          minimumSize: const Size.fromHeight(40.0),
        ),
      ),
      chipTheme: ChipThemeData(
          labelStyle: textTheme.labelMedium,
          selectedColor: primaryYellow,
          backgroundColor: primaryYellow,
          disabledColor: primaryYellow,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: disabledText),
              borderRadius: BorderRadius.circular(100.0)),
          side: BorderSide(color: disabledText)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryYellow,
        elevation: 4,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: primaryBlack,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        behavior: SnackBarBehavior.floating,
      ),
      listTileTheme:
          theme.listTileTheme.copyWith(titleTextStyle: textTheme.titleSmall),
      popupMenuTheme: theme.popupMenuTheme.copyWith(
          labelTextStyle: WidgetStatePropertyAll(textTheme.titleMedium),
          textStyle: textTheme.titleMedium),
      switchTheme: theme.switchTheme.copyWith(
        trackColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? colorScheme.outline
                : colorScheme.surfaceContainer),
        thumbColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? white
                : colorScheme.outline),
      ),
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        ...theme.pageTransitionsTheme.builders,
        TargetPlatform.android: CupertinoPageTransitionsBuilder()
      }),
      textTheme: textTheme,
    );
  }

  static ThemeData lightTheme(BuildContext context) {
    final baseTheme = _baseTheme(context, Brightness.light);
    final colorScheme = baseTheme.colorScheme;

    return baseTheme.copyWith(
        colorScheme: colorScheme.copyWith(surface: white),
        scaffoldBackgroundColor: white,
        appBarTheme: baseTheme.appBarTheme.copyWith(
            systemOverlayStyle: const SystemUiOverlayStyle(
                systemNavigationBarColor: white,
                systemNavigationBarDividerColor: white,
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark)),
        bottomNavigationBarTheme: baseTheme.bottomNavigationBarTheme.copyWith(
          backgroundColor: white,
          selectedItemColor: colorScheme.onPrimary,
          unselectedItemColor: baseTheme.disabledColor,
        ),
        bottomSheetTheme: baseTheme.bottomSheetTheme.copyWith(
          backgroundColor: white,
        ),
        chipTheme: baseTheme.chipTheme.copyWith(
          backgroundColor: white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: baseTheme.elevatedButtonTheme.style?.copyWith(
          backgroundColor: WidgetStatePropertyAll(primaryYellow),
          foregroundColor: WidgetStatePropertyAll(mainText),
        )),
        floatingActionButtonTheme: baseTheme.floatingActionButtonTheme.copyWith(
          foregroundColor: mainText,
        ),
        tabBarTheme: baseTheme.tabBarTheme.copyWith(
          labelColor: colorScheme.onPrimary,
          unselectedLabelColor: baseTheme.disabledColor,
          indicator: UnderlineTabIndicator(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(width: 4.0),
          ),
          indicatorColor: colorScheme.onPrimary,
          overlayColor: const WidgetStatePropertyAll(lightGrey),
        ),
        textButtonTheme: TextButtonThemeData(
            style: baseTheme.textButtonTheme.style?.copyWith(
          foregroundColor: WidgetStatePropertyAll(mainText),
        )));
  }

  static ThemeData darkTheme(BuildContext context) {
    final baseTheme = _baseTheme(context, Brightness.dark);
    final colorScheme =
        baseTheme.colorScheme.copyWith(surface: Color(0XFF1A1A1A));

    return baseTheme.copyWith(
        colorScheme: colorScheme.copyWith(
            onTertiary: white, onSurfaceVariant: Color(0xffCFC5B4)),
        scaffoldBackgroundColor: colorScheme.surface,
        appBarTheme: baseTheme.appBarTheme.copyWith(
            systemOverlayStyle: SystemUiOverlayStyle(
                systemNavigationBarColor: colorScheme.surface,
                systemNavigationBarDividerColor: colorScheme.surface,
                systemNavigationBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light)),
        bottomNavigationBarTheme: baseTheme.bottomNavigationBarTheme.copyWith(
          backgroundColor: colorScheme.surface,
          selectedItemColor: colorScheme.onPrimary,
          unselectedItemColor: colorScheme.onSurfaceVariant,
        ),
        bottomSheetTheme: baseTheme.bottomSheetTheme.copyWith(
          backgroundColor: colorScheme.surface,
        ),
        chipTheme: baseTheme.chipTheme.copyWith(
          labelStyle: baseTheme.chipTheme.labelStyle?.copyWith(
            color: primaryBlack,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: baseTheme.elevatedButtonTheme.style?.copyWith(
          backgroundColor: WidgetStatePropertyAll(primaryYellow),
          foregroundColor: WidgetStatePropertyAll(mainText),
        )),
        filledButtonTheme: FilledButtonThemeData(
            style: baseTheme.filledButtonTheme.style
                ?.copyWith(foregroundColor: WidgetStatePropertyAll(mainText))),
        floatingActionButtonTheme: baseTheme.floatingActionButtonTheme.copyWith(
          foregroundColor: primaryBlack,
        ),
        listTileTheme: baseTheme.listTileTheme.copyWith(
            titleTextStyle: baseTheme.listTileTheme.titleTextStyle?.copyWith(
          color: colorScheme.onSurface,
        )),
        popupMenuTheme: baseTheme.popupMenuTheme.copyWith(
          color: colorScheme.surfaceContainerHighest,
          labelTextStyle: WidgetStatePropertyAll(
              TextStyle(color: colorScheme.onSurfaceVariant)),
        ),
        radioTheme: baseTheme.radioTheme
            .copyWith(fillColor: WidgetStatePropertyAll(colorScheme.outline)),
        tabBarTheme: baseTheme.tabBarTheme.copyWith(
          labelColor: white,
          unselectedLabelColor: baseTheme.disabledColor,
          indicator: UnderlineTabIndicator(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: white, width: 4.0),
          ),
          indicatorColor: white,
          overlayColor:
              WidgetStatePropertyAll(colorScheme.surfaceContainerHighest),
        ),
        textButtonTheme: TextButtonThemeData(
            style: baseTheme.textButtonTheme.style?.copyWith(
          foregroundColor: WidgetStatePropertyAll(lightGrey),
        )),
        textTheme: baseTheme.textTheme.apply(
          bodyColor: lightGrey,
          displayColor: white,
        ));
  }

  static ThemeData primaryColorTheme(BuildContext context) {
    final baseTheme = lightTheme(context);

    return baseTheme.copyWith(
        scaffoldBackgroundColor: primaryYellow,
        appBarTheme: baseTheme.appBarTheme.copyWith(
            backgroundColor: primaryYellow,
            systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarColor: primaryYellow,
              systemNavigationBarDividerColor: primaryYellow,
              statusBarBrightness: Brightness.light,
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            )));
  }

  static ThemeData fullBlackTheme(BuildContext context) {
    final baseTheme = _baseTheme(context, Brightness.dark);
    final colorScheme = _colorScheme(Brightness.dark);

    return baseTheme.copyWith(
      brightness: Brightness.dark,
      textTheme: baseTheme.textTheme.apply(bodyColor: white).copyWith(
          labelMedium:
              baseTheme.textTheme.labelMedium!.copyWith(color: darkSecondary)),
      appBarTheme: baseTheme.appBarTheme.copyWith(
          backgroundColor: black,
          foregroundColor: colorScheme.onSurface,
          iconTheme: baseTheme.appBarTheme.iconTheme
              ?.copyWith(color: colorScheme.onSurface),
          titleTextStyle: baseTheme.appBarTheme.titleTextStyle
              ?.copyWith(color: colorScheme.onSurface),
          systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarColor: black,
              systemNavigationBarDividerColor: black,
              statusBarBrightness: Brightness.dark,
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light)),
      scaffoldBackgroundColor: black,
    );
  }
}
