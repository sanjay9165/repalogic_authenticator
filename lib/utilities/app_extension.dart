import 'package:repalogic_authenticator/utilities/common_exports.dart';

extension BuildContextExtensions on BuildContext {
  // NAVIGATION METHODS
  void pop() => Navigator.of(this).pop();

  void mayBePop() async => await Navigator.of(this).maybePop();

  Future<dynamic> pushNamed(String routeName, {Object? arguments}) =>
      Navigator.pushNamed(this, routeName, arguments: arguments);

  void popAndPushNamed(String routeName, {Object? arguments}) =>
      Navigator.popAndPushNamed(this, routeName, arguments: arguments);

  void pushReplacementNamed(String routeName, {Object? arguments}) =>
      Navigator.pushReplacementNamed(this, routeName, arguments: arguments);

  void pushNamedAndRemoveUntil(String routeName, {Object? arguments}) =>
      Navigator.pushNamedAndRemoveUntil(
        this,
        routeName,
        (route) => false,
        arguments: arguments,
      );

  // TEXT THEME
  TextTheme get textTheme => Theme.of(this).textTheme;

  double getScreenHeight(double value) =>
      MediaQuery.of(this).size.height * value;

  double getScreenWidth(double value) => MediaQuery.of(this).size.width * value;
}

extension FormValidation on String {
  String get _emailPattern =>
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  bool get emailValidation => RegExp(_emailPattern).hasMatch(this);

  bool get isValidPassword => RegExp(
    r'^(?=(.*[a-z]){3,})(?=(.*[A-Z]){1,})(?=(.*[0-9]){2,})(?=(.*[!@#$%^&*()-__+.]){1,}).{8,}$',
  ).hasMatch(this);

  bool get isValidPhone => RegExp(r'(^(?:[+0]9)?[0-9]{10}$)').hasMatch(this);
}
