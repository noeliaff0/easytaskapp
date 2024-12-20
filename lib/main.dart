import 'package:easytaskapp/navigation/go_router.dart';
import 'package:easytaskapp/presentation/providers/auth.provider.dart';
import 'package:easytaskapp/presentation/providers/task.provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          // Crea una instancia de AppRouter y pasa el AuthProvider
          final appRouter = AppRouter(authProvider);

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Firebase Auth',
            theme: ThemeData(primarySwatch: Colors.blue),
            routerDelegate: appRouter.router.routerDelegate,
            routeInformationParser: appRouter.router.routeInformationParser,
            routeInformationProvider: appRouter.router.routeInformationProvider,
          );
        },
      ),
    );
  }
}
