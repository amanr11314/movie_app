import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/movie_app.dart';

void main() async {
  await dotenv.load();
  runApp(ProviderScope(child: MyApp()));
}
