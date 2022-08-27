import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// SecureStorage imports.
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// Bloc imports.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_notes/cubits/cubits.dart';
// Firebase imports.
import 'package:mine_notes/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
// Pages imports.
import 'package:mine_notes/pages/pages.dart';
import 'package:mine_notes/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final Widget currentHomePage =
      await const FlutterSecureStorage().read(key: 'token') != null
          ? const HomePages()
          : const WelcomePage();
  runApp(MyApp(currentHomePage: currentHomePage));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.currentHomePage}) : super(key: key);
  final Widget currentHomePage;

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    // Set status bar color to transparent.
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MultiBlocProvider(
      providers: [
        // * Network Cubit is used to check internet connection.
        BlocProvider<NetworkCubit>(create: (context) => NetworkCubit()),
        // * Home navigation cubit for navigation between different screens.
        BlocProvider<HomeNavigationCubit>(
            create: (context) => HomeNavigationCubit()),
        // * Account cubit is used to manage user account.
        BlocProvider<AccountCubit>(create: (context) => AccountCubit()),
        // * App data cubit is used to manage app data.
        // ? Add SearchCubit
        BlocProvider<AppDataCubit>(create: (context) => AppDataCubit()),
        // * Note cubit is used to manage note operations.
        BlocProvider<NoteCubit>(create: (context) => NoteCubit()),
        // * Category cubit is used to manage category operations.
        BlocProvider<CategoryCubit>(create: (context) => CategoryCubit()),
      ],
      child: BlocConsumer<NetworkCubit, NetworkState>(
        listener: (context, state) {
          // Showing if the device is connected to the internet.
          ScaffoldMessenger.of(context).showSnackBar(
              // Cubit will emit the snackbar according to the state.
              BlocProvider.of<NetworkCubit>(context)
                  .getSnackbar(context, state));
        },
        builder: (context, state) {
          // Check if the device is connected to the internet.
          BlocProvider.of<NetworkCubit>(context).checkConnection();
          return MaterialApp(
            title: 'Mine Notes',
            home: currentHomePage,
            debugShowCheckedModeBanner: false,
            color: Theme.of(context).canvasColor,
            themeMode: ThemeMode.light,
            theme: AppTheme.lightTheme(context),
            darkTheme: AppTheme.darkTheme(context),
            onGenerateRoute: AppRoutes.generateRoute,
          );
        },
      ),
    );
  }
}
