import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseConfig {
  static FirebaseFirestore? _firestore;
  static FirebaseAuth? _auth;
  static FirebaseStorage? _storage;
  static FirebaseMessaging? _messaging;

  // Configuration Firebase pour l'application utilisateurs
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "YOUR_API_KEY",
        authDomain: "algerian-workers.firebaseapp.com",
        projectId: "algerian-workers",
        storageBucket: "algerian-workers.appspot.com",
        messagingSenderId: "YOUR_SENDER_ID",
        appId: "YOUR_APP_ID",
      ),
    );

    _firestore = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
    _storage = FirebaseStorage.instance;
    _messaging = FirebaseMessaging.instance;

    // Configuration Firestore pour la synchronisation temps réel
    _firestore!.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );

    // Configuration des notifications push
    await _configureMessaging();
  }

  static Future<void> _configureMessaging() async {
    final settings = await _messaging!.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final token = await _messaging!.getToken();
      print('FCM Token: $token');
    }
  }

  // Getters pour accéder aux instances Firebase
  static FirebaseFirestore get firestore => _firestore!;
  static FirebaseAuth get auth => _auth!;
  static FirebaseStorage get storage => _storage!;
  static FirebaseMessaging get messaging => _messaging!;
}