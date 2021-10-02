import 'package:flutter/material.dart';
import 'home_page.dart';

void main() => runApp(MaterialApp(
  home: const HomePage(),
  theme: ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xff121212),
    ),
  )
);
