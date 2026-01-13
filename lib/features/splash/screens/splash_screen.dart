import 'package:repalogic_authenticator/utilities/common_exports.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    try {
      final hiveService = HiveService();
      final isLoggedIn = await hiveService.isLoggedIn();

      if (!mounted) return;

      if (isLoggedIn) {
        Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.lock_outline,
                size: 60,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 32),

            Text(
              'Authenticator',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              'Secure Authentication',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColors.lightGray),
            ),
            const SizedBox(height: 48),

            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
