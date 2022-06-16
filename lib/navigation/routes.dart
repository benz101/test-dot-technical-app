import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_dot_technical_app/view/error_page.dart';
import 'package:test_dot_technical_app/view/home_page.dart';
import 'package:test_dot_technical_app/view/login_page.dart';
import 'package:test_dot_technical_app/view/splash_page.dart';

class Routes extends StatelessWidget {
  const Routes({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // initialRoute: SplashPage.routeName,
      home: SplashPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case '/splashPage':
        return MaterialPageRoute(builder: (_)=> const SplashPage());
      case '/loginPage':
        return MaterialPageRoute(builder: (_)=> const LoginPage());
      case '/homePage':
        return MaterialPageRoute(builder: (_)=> const HomePage());
      default:
      return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_) => const ErrorPage());
  }
  
}