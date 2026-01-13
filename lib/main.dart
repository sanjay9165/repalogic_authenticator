import 'package:repalogic_authenticator/utilities/common_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register TypeAdapter before initializing Hive
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(UserModelAdapter());
  }

  // Initialize Hive
  await HiveService().init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().light,
      initialRoute: Routes.splashScreen,
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: NavigationService.generateRoute,
    );
  }
}
