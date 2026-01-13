import 'package:repalogic_authenticator/utilities/common_exports.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: AppConstants.dontHaveAccountText,
          style: context.textTheme.bodyMedium?.copyWith(color: AppColors.black),
          children: [
            WidgetSpan(
              child: GestureDetector(
                onTap: () => context.pushNamed(Routes.registerScreen),
                child: Text(
                  AppConstants.signUpButton,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
