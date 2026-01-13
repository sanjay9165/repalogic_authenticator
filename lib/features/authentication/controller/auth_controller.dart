import 'package:repalogic_authenticator/utilities/common_exports.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final UserModel? user;
  final bool isAuthenticated;

  AuthState({
    this.isLoading = false,
    this.error,
    this.user,
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    UserModel? user,
    bool? isAuthenticated,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  final HiveService _hiveService;

  AuthController(this._hiveService) : super(AuthState()) {
    _checkAuthStatus();
  }

  // Check if user is already logged in
  Future<void> _checkAuthStatus() async {
    try {
      final user = await _hiveService.getLoggedInUser();
      if (user != null) {
        state = state.copyWith(user: user, isAuthenticated: true);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Login method
  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final success = await _hiveService.login(
        email: email,
        password: password,
      );

      if (success) {
        final user = await _hiveService.getLoggedInUser();
        state = state.copyWith(
          isLoading: false,
          user: user,
          isAuthenticated: true,
          error: null,
        );
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: AppConstants.invalidCredentialsError,
          isAuthenticated: false,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        isAuthenticated: false,
      );
      return false;
    }
  }

  // Register method
  Future<bool> register({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final success = await _hiveService.signup(
        name: name,
        phone: phone,
        email: email,
        password: password,
      );

      if (success) {
        state = state.copyWith(isLoading: false, error: null);
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: AppConstants.emailExistsError,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      await _hiveService.logout();
      state = AuthState();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

// Provider for HiveService
final hiveServiceProvider = Provider<HiveService>((ref) {
  return HiveService();
});

// Provider for AuthController
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    final hiveService = ref.watch(hiveServiceProvider);
    return AuthController(hiveService);
  },
);
