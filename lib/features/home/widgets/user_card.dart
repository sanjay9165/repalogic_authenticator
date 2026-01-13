import 'package:repalogic_authenticator/utilities/common_exports.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.darkGunmetal,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: AppColors.primaryColor, size: 32),
                const SizedBox(width: 12),
                Text('User Information', style: context.textTheme.displayLarge),
              ],
            ),
            const SizedBox(height: 24),
            _buildInfoRow(context, 'Name', user.name, Icons.person_outline),
            const SizedBox(height: 16),
            _buildInfoRow(context, 'Email', user.email, Icons.email_outlined),
            const SizedBox(height: 16),
            _buildInfoRow(context, 'Phone', user.phone, Icons.phone_outlined),
          ],
        ),
      ),
    );
  }
}

Widget _buildInfoRow(
  BuildContext context,
  String label,
  String value,
  IconData icon,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: AppColors.primaryColor, size: 20),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: context.textTheme.titleSmall),
            const SizedBox(height: 4),
            Text(value, style: context.textTheme.displayMedium),
          ],
        ),
      ),
    ],
  );
}
