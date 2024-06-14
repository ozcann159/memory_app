import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_app/bloc/memory_bloc.dart';
import 'package:memory_app/firebase_options.dart';
import 'package:memory_app/pages/memories_list_screen.dart.dart';
import 'package:memory_app/repo/memory_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MemoryBloc>(
          create: (context) => MemoryBloc(MemoryRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hatıra Defteri',
        home: MemoryListPage(),
      ),
    );
  }
}
