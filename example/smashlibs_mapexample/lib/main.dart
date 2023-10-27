import 'package:flutter/material.dart';
import 'package:smashlibs/smashlibs.dart';
import './org/geopaparazz/smash/example/mainview.dart';
import 'package:provider/provider.dart';
import 'package:smashlibs/generated/l10n.dart';

void main() {
  runApp(getMainWidget());
}

MultiProvider getMainWidget() {
  return MultiProvider(
    providers: [
      // ChangeNotifierProvider(create: (_) => ProjectState()),
      ChangeNotifierProvider(create: (_) => SmashMapBuilder()),
      ChangeNotifierProvider(create: (_) => ThemeState()),
      ChangeNotifierProvider(create: (_) => GpsState()),
      ChangeNotifierProvider(create: (_) => SmashMapState()),
      ChangeNotifierProvider(create: (_) => InfoToolState()),
      ChangeNotifierProvider(create: (_) => RulerState()),
      ChangeNotifierProvider(create: (_) => GeometryEditorState()),
    ],
    child: const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smashlibs Demo',
      localizationsDelegates: SLL.localizationsDelegates,
      supportedLocales: SLL.supportedLocales,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: SmashColors.mainDecorations),
        useMaterial3: true,
      ),
      home: const MainSmashLibsPage(title: 'Smashlibs Demo'),
    );
  }
}
