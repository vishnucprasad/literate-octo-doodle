import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_providers.g.dart';

@riverpod
FirebaseAuth auth(Ref ref) => FirebaseAuth.instance;

@riverpod
FirebaseFirestore database(Ref ref) => FirebaseFirestore.instance;

@riverpod
FirebaseStorage firebaseStorage(Ref ref) => FirebaseStorage.instance;
