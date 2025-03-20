import 'package:aaraadhya_temple_dashboard/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env.dev");
  runApp(const AaraadhyaTempleApp());
}
