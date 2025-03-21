import 'package:aaraadhya_temple_dashboard/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await dotenv.load(fileName: ".env.dev");
  runApp(ProviderScope(child: const AaraadhyaTempleApp()));
}
