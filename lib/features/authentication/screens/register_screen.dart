import 'package:repalogic_authenticator/utilities/common_exports.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      final authController = ref.read(authControllerProvider.notifier);
      final success = await authController.register(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppConstants.registrationSuccessMessage)),
        );
        // Navigate back to login screen
        Navigator.of(context).pop();
      } else if (mounted) {
        final error = ref.read(authControllerProvider).error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error ?? AppConstants.registrationFailedMessage),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RegisterHeader(),
                    CustomTextField(
                      label: AppConstants.fullNameLabel,
                      hintText: AppConstants.fullNameHint,
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppConstants.nameEmptyError;
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    CustomTextField(
                      label: AppConstants.phoneNumberLabel,
                      hintText: AppConstants.phoneNumberHint,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppConstants.phoneEmptyError;
                        }
                        if (!value.isValidPhone) {
                          return AppConstants.phoneInvalidError;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
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

                        if (value.length >= 8 && !value.isValidPassword) {
                          return AppConstants.passwordStrengthError;
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    CustomButton(
                      text: AppConstants.signUpButton,
                      onPressed: authState.isLoading ? null : _handleSignUp,
                    ),
                    if (authState.isLoading)
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    SizedBox(height: 24),
                    RegisterFooter(),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
