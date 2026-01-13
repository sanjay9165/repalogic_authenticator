import 'package:repalogic_authenticator/utilities/common_exports.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    final authController = ref.read(authControllerProvider.notifier);
    await authController.logout();

    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppConstants.logoutSuccessMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final user = authState.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.homeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.white),
            onPressed: () => _handleLogout(context, ref),
            tooltip: AppConstants.logoutTooltip,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: user == null
              ? const Center(child: Text(AppConstants.noUserInfoMessage))
              : UserCard(user: user),
        ),
      ),
    );
  }
}
