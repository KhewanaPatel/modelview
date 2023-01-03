import 'package:flutter/material.dart';
import 'package:modelview/utils/routes/routes.dart';
import 'package:modelview/utils/routes/routes_name.dart';
import 'package:modelview/view/login_view.dart';
import 'package:modelview/view/splash_view.dart';
import 'package:modelview/view_model/auth_view_model.dart';
import 'package:modelview/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:[
      ChangeNotifierProvider(create:(_)=>AuthViewModel()),
      ChangeNotifierProvider(create: (_)=>UserViewModel())
    ],
    child: MaterialApp(
    title: "flutter Demo",
    theme: ThemeData(
    primarySwatch: Colors.lightBlue
    ),
    initialRoute: RoutesName.splash,
    onGenerateRoute: Routes.generateRoute,
    debugShowCheckedModeBanner: false,
    home: LoginView(),
    ));
  }
}

