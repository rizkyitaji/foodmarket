import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodmarket/cubit/cubit.dart';
import 'package:get/get.dart';
import 'ui/pages/pages.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   runApp(MyApp(pref: pref));
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final SharedPreferences pref;

  // MyApp({this.pref});

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => FoodCubit()),
        BlocProvider(create: (_) => TransactionCubit()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignInPage(),
        // home: (getToken != null) ? MainPage() : SignInPage(),
      ),
    );
  }
}
