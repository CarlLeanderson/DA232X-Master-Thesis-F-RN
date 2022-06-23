import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:master_store_f/screens/LoginScreen.dart';
import 'models/store.dart';
import 'store/app_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
          theme: ThemeData(fontFamily: 'open-sans'),
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: const AuthScreen()),
    );
  }
}
