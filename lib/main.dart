import 'package:flutter/material.dart';
import 'package:todolist/pages/todolist_page.dart';
import 'package:todolist/utils/get_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
       theme: //ThemeData.light(),
      // darkTheme: ThemeData.dark(),
       ThemeData(
      //
      //   //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
         useMaterial3: true,
         scaffoldBackgroundColor: GetColor().primary,


         inputDecorationTheme: const InputDecorationTheme(
           //focusColor: Colors.black54,
          labelStyle: TextStyle(
            fontSize: 16,
           ),
           ),

         textTheme: const TextTheme(
           displayLarge: TextStyle(
             color: Colors.white
           ),
           bodyMedium: TextStyle(
             fontSize: 18,
             color: Colors.black54
           ),
         ),
         appBarTheme: AppBarTheme(
           backgroundColor: GetColor().secondary,
           titleTextStyle: const TextStyle(
             color: Colors.white,
             fontSize: 26
           )
         ),

       ),
      debugShowCheckedModeBanner: false,
      home: const TodoListPage(),
    );
  }
}


