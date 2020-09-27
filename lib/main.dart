import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:justmnts/AuthStore.dart';
import 'package:justmnts/positions/CreatePositionPage.dart';
import 'package:justmnts/positions/PositionsPage.dart';
import 'package:provider/provider.dart';

import 'MainStore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainStore()),
        ChangeNotifierProvider(create: (_) => AuthStore()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: Color.fromRGBO(71, 71, 71, 1),
          accentColor: Color.fromRGBO(151, 153, 235, 1),

          // Define the default font family.
          // fontFamily: 'Georgia',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => Consumer<AuthStore>(
              builder: (context, model, _) {
                print("hasCurrentUser: ${model.hasCurrentUser}");
                print("user not null: ${model.user != null}");
                if (model.hasCurrentUser || model.user != null) {
                  return PositionsPage(title: 'Positions');
                } else {
                  model.anonSignIn();
                  return Center(
                      widthFactor: 3,
                      heightFactor: 3,
                      child: CircularProgressIndicator(
                          strokeWidth: 3,
                          backgroundColor: Color.fromRGBO(71, 71, 71, 1),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromRGBO(151, 153, 235, 1))));
                }
              },
            ),
        // When navig ating to the "/second" route, build the SecondScreen widget.
        '/create-position': (context) => CreatePositionPage(),
      },
    );
  }
}
