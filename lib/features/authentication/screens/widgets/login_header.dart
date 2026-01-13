import 'package:repalogic_authenticator/utilities/common_exports.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppIcons.users,
          height: 300,
          width: context.getScreenWidth(1),
        ),

        Text(
          AppConstants.appName,
          style: context.textTheme.displayLarge?.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
        ),
      ],
    );
  }
}
