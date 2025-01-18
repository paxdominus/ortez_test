import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ortez_test/provider/todo_provider.dart';
import 'package:ortez_test/view/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TodoProvider(),
          builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Ortez Test',
            theme: ThemeData(
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
              colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromARGB(255, 31, 219, 204)),
              useMaterial3: true,
            ),
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          ),
        ),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    TodoProvider().fetchTodoModels();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
