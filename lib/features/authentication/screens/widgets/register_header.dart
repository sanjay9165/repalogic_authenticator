import 'package:repalogic_authenticator/utilities/common_exports.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Icon(Icons.person, size: 80),
        SizedBox(height: 10),
        Text(
          AppConstants.createAccountTitle,
          textAlign: TextAlign.center,
          style: context.textTheme.displayLarge?.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
