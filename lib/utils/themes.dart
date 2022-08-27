import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

const _colorPrimary = Color(0xFFF9A826);
// const _colorText = Color(0xFF343437);
// const _colorTextLight = Color(0xFFACA4A4);

class AppTheme {
  // Light theme
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      // Flag for set theme to material3 theme
      useMaterial3: true,

      // Colors for the theme
      colorScheme: ColorScheme.fromSeed(
        seedColor: _colorPrimary,
        primary: _colorPrimary,
      ),

      // Text colors and fonts
      textTheme: const TextTheme(),

      // Checkbox colors and shape
      checkboxTheme: CheckboxThemeData(
        fillColor: Theme.of(context).checkboxTheme.fillColor,
        checkColor: Theme.of(context).checkboxTheme.checkColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),

      // FloatingActionButton colors, shape and size
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _colorPrimary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        focusColor: Theme.of(context).colorScheme.primary,
        hoverColor: Theme.of(context).colorScheme.primary,
        splashColor: Theme.of(context).colorScheme.primary,
        iconSize: 36,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(20)),
        ),
        enableFeedback: true,
      ),

      // ListTile colors and shape
      listTileTheme: ListTileThemeData(
        tileColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),

      // Bottom-sheet colors and shape
      bottomSheetTheme: const BottomSheetThemeData(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
      ),

      // Snackbar colors and shape
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.fixed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8),
          ),
        ),
      ),
    );
  }

  // Dark theme
  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
    );
  }
}

class SliderColors {
  // * Class for get list of note cards colors(use in color slider).
  static const notesColors = [
    Color(0xffffffff), // classic white
    Color(0xfff28b81), // light pink
    Color(0xfff7bd02), // yellow
    Color(0xfffbf476), // light yellow
    Color(0xffcdff90), // light green
    Color(0xffa7feeb), // turquoise
    Color(0xffcbf0f8), // light cyan
    Color(0xffafcbfa), // light blue
    Color(0xffd7aefc), // plum
    Color(0xfffbcfe9), // misty rose
    Color(0xffe6c9a9), // light brown
    Color(0xffe9eaee) // light gray
  ];

  // * Class for get list of category cards colors(use in color slider).
  static const categoriesColors = [
    Color(0xFFFA0F1B), // red pigment
    Color(0xFFFC6E22), // orange red
    Color(0xFFF49F01), // orange web
    Color(0xFF9CBE37), // android green
    Color(0xFF1BACC6), // pacific blue
    Color(0xFFE9DFA5) // medium champagne
  ];

  static const Color borderColor = Color(0xffd3d3d3);
  static const Color foregroundColor = Color(0xff595959);
}

class ListIcons {
  // * Class for get list of category cards icon(use in choose category icon bar).
  static const categoriesIcons = [
    Iconsax.note_1,
    Icons.done_rounded,
    Iconsax.book,
    Icons.book_rounded,
    Icons.my_library_books,
    Icons.today_rounded,
  ];
}
