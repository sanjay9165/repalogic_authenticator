import 'package:repalogic_authenticator/utilities/common_exports.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      final authController = ref.read(authControllerProvider.notifier);
      final success = await authController.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppConstants.loginSuccessMessage)),
        );
        Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
      } else if (mounted) {
        final error = ref.read(authControllerProvider).error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error ?? AppConstants.loginFailedMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LoginHeader(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextField(
                        label: AppConstants.emailLabel,
                        hintText: AppConstants.emailHint,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppConstants.emailEmptyError;
                          }
                          if (!value.emailValidation) {
                            return AppConstants.emailInvalidError;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),
                      CustomTextField(
                        label: AppConstants.passwordLabel,
                        hintText: AppConstants.passwordHint,
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppConstants.passwordEmptyError;
                          }

                          if (value.length < 8) {
                            return AppConstants.passwordLengthError;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),
                      CustomButton(
                        text: AppConstants.loginButton,
                        onPressed: authState.isLoading ? null : _handleLogin,
                      ),
                      if (authState.isLoading)
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      SizedBox(height: 24),
                      LoginFooter(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
