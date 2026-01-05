import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/providers/theme_provider.dart';
import '../data/providers/movie_provider.dart';
import '../data/providers/favorites_provider.dart';
import 'routes.dart';
import '../theme/app_theme.dart' as MyAppTheme;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => MovieProvider()),
          ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _){
          return MaterialApp(
          title: 'Movie App',
          debugShowCheckedModeBanner: false,
          theme: MyAppTheme.AppThemes.lightTheme,
          darkTheme: MyAppTheme.AppThemes.darkTheme,
          themeMode: themeProvider.themeMode,
          onGenerateRoute: Routes.onGenerateRoute,
          );
        },
      ),
    );
  }
}
