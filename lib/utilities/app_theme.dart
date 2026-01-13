import 'package:repalogic_authenticator/utilities/common_exports.dart';

class AppTheme {
  factory AppTheme() => _singleton;

  static final AppTheme _singleton = AppTheme._internal();

  AppTheme._internal();

  ThemeData get light => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    scaffoldBackgroundColor: AppColors.formBackground,
    primaryColor: AppColors.primaryColor,
    iconTheme: const IconThemeData(color: AppColors.primaryColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      iconTheme: IconThemeData(color: AppColors.primaryColor),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: AppFonts.ulagadiSansRegular,
        color: AppColors.white,
      ),
    ),
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.ulagadiSansRegular,
        color: AppColors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: AppFonts.ulagadiSansMedium,
        color: AppColors.white,
      ),
      displayLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: AppFonts.ulagadiSansBold,
        color: AppColors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.ulagadiSansRegular,
        color: AppColors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        fontFamily: AppFonts.ulagadiSansLight,
        color: AppColors.white,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.ulagadiSansRegular,
        color: AppColors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.ulagadiSansRegular,
        color: AppColors.lightGray,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.ulagadiSansRegular,
        color: AppColors.primaryColor,
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size(double.maxFinite, 50)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 16,
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.ulagadiSansBold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: AppFonts.ulagadiSansRegular,
            color: AppColors.primaryColor,
          ),
        ),
        foregroundColor: const WidgetStatePropertyAll(AppColors.primaryColor),
        overlayColor: WidgetStatePropertyAll(AppColors.primaryColor),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.formBackground,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      isDense: true,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontFamily: AppFonts.ulagadiSansRegular,
        color: AppColors.black,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: const TextStyle(
        fontSize: 12,
        fontFamily: AppFonts.ulagadiSansRegular,
        color: AppColors.error,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: const TextStyle(
        fontSize: 14,
        fontFamily: AppFonts.ulagadiSansRegular,
        color: AppColors.lightGray,
        fontWeight: FontWeight.w400,
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.brightYellow, width: 2),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightGray, width: 2),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.brightYellow, width: 2),
      ),
    ),
  );
}
