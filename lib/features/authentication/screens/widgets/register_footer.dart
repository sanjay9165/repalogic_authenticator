import 'package:repalogic_authenticator/utilities/common_exports.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Already have an account? ",
          style: context.textTheme.bodyMedium?.copyWith(color: AppColors.black),
          children: [
            WidgetSpan(
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Text(
                  'LOGIN',
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
