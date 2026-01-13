import 'package:repalogic_authenticator/utilities/common_exports.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  HiveService._internal();

  static const String _userBoxName = 'users';
  static const String _userEmailKey = 'user_email';
  Box<UserModel>? _userBox;

  // Initialize Hive with application directory
  Future<void> init() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);
      await openBox();
    } catch (e) {
      throw Exception('Failed to initialize Hive: $e');
    }
  }

  // Open the user box
  Future<void> openBox() async {
    try {
      _userBox = await Hive.openBox<UserModel>(_userBoxName);
    } catch (e) {
      throw Exception('Failed to open box: $e');
    }
  }

  // Sign up a new user
  Future<bool> signup({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      if (_userBox == null) {
        await openBox();
      }

      // Check if user with this email already exists
      final existingUser = _userBox!.values.firstWhere(
        (user) => user.email.toLowerCase() == email.toLowerCase(),
        orElse: () => UserModel(name: '', phone: '', email: '', password: ''),
      );

      if (existingUser.email.isNotEmpty) {
        return false;
      }

      // Create new user
      final newUser = UserModel(
        name: name,
        phone: phone,
        email: email,
        password: password,
      );

      await _userBox!.add(newUser);
      return true;
    } catch (e) {
      throw Exception('Failed to signup: $e');
    }
  }

  /// Login a user
  Future<bool> login({required String email, required String password}) async {
    try {
      if (_userBox == null) {
        await openBox();
      }

      // Find user with matching email
      final user = _userBox!.values.firstWhere(
        (user) => user.email.toLowerCase() == email.toLowerCase(),
        orElse: () => UserModel(name: '', phone: '', email: '', password: ''),
      );

      if (user.email.isEmpty) {
        return false;
      }

      // Check password
      if (user.password != password) {
        return false;
      }

      // Store email in SharedPreferences for session management
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userEmailKey, user.email);

      return true;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  /// Logout user by clearing SharedPreferences
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userEmailKey);
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString(_userEmailKey);
      return email != null && email.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Get logged in user email
  Future<String?> getLoggedInUserEmail() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_userEmailKey);
    } catch (e) {
      return null;
    }
  }

  /// Get logged in user details
  Future<UserModel?> getLoggedInUser() async {
    try {
      if (_userBox == null) {
        await openBox();
      }

      final email = await getLoggedInUserEmail();
      if (email == null || email.isEmpty) {
        return null;
      }

      // Find user with matching email
      final user = _userBox!.values.firstWhere(
        (user) => user.email.toLowerCase() == email.toLowerCase(),
        orElse: () => UserModel(name: '', phone: '', email: '', password: ''),
      );

      if (user.email.isEmpty) {
        return null;
      }

      return user;
    } catch (e) {
      return null;
    }
  }
}
