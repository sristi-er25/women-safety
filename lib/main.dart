import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:women_safety/firebase_options.dart';
import 'package:women_safety/pages/login.dart';
import 'package:women_safety/pages/homepage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:women_safety/pages/sign_up_page.dart';
// import 'package:telephony/telephony.dart';

void main() {
  runApp(MyApp());
  // WidgetsFlutterBinding.ensureInitialized();
  // initializeService();  // Start background service

  //   void main() {
  //   runApp(MaterialApp(home: SignUpPage()));
  // }
}

Future<bool> onStart(ServiceInstance service) async {
  VoiceService voiceService = VoiceService();
  voiceService.startListening((p0) {});

  service.on('stopService').listen((event) {
    voiceService.stopListening();
    service.stopSelf();
  });
  return true;
}

void initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: onStart,
    ),
  );

  service.startService();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Color(0xff142831)),
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/signup': (context) => SignUpPage(),
      }, // home: Login(),
      //  SignUpPage()
    );
  }
}

// class Homepage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Voice Detection")),
//       body: Center(child: Text("Background detection active")),
//     );
//   }
// }

// actions: <Widget>[
//   IconButton(
//     icon: const Icon(Icons.notifications),
//      onPressed: () {},
//   ),
// ],

// leading: IconButton(
//   onPressed: () {},
//   icon: IconButton(
//     icon: const Icon(Icons.menu),
//     onPressed: () {},

//   ),
// ),
//     );
//   }
// }

// LOGIN SCREEN

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  // Method to handle the login action
  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      // If form is valid, save the values and navigate to the next screen
      _formKey.currentState?.save();

      // You can add authentication logic here, like Firebase sign-in or any other logic.
      // For now, let's assume login is successful.

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 530,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(90),
                  bottomRight: Radius.circular(90),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              ),
                              hintText: 'Email id',
                              fillColor: Colors.grey[300],
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email';
                              } else if (!RegExp(
                                r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$",
                              ).hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              email = value!;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.key,
                                color: Theme.of(context).primaryColor,
                              ),
                              hintText: 'Password',
                              fillColor: Colors.grey[300],
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            obscureText: true, // Hide password
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              password = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: 240,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: _login, // Trigger the login action
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to Sign Up page
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text("Sign Up"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   void _login() {
//     String username = _usernameController.text;
//     String password = _passwordController.text;

//     if (username == "user" && password == "1234") {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => HomePage()));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Invalid credentials! Try again.")));
//     }
//  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Login")),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: "Username"),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: "Password"),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(onPressed: _login, child: Text("Login")),
//           ],
//         ),
//       ),
//     );
//   }
// }

// HOMEPAGE WITH LOCATION & VOICE SERVICES
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void startVoiceService() {
    print(
      "Voice detection started",
    ); // Replace with actual voice detection logic
  }

  void openLocationService() {
    print("Location service activated"); // Replace with actual location logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },

            // Navigator.pushReplacement(
            //     context, MaterialPageRoute(builder: (context) => Login()));
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: startVoiceService,
              child: Text("Add Emergency Contacts"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: startVoiceService,
              child: Text("Record voice"),
            ),
          ],
        ),
      ),
    );
  }
}

// VOICE SERVICE
class VoiceService {
  final SpeechToText speech = SpeechToText();

  Future<bool> startListening(Function(String) onResult) async {
    bool available = await speech.initialize();
    if (!available) return false;

    speech.listen(
      onResult: (result) {
        String spokenText = result.recognizedWords.toLowerCase();
        onResult(spokenText);
      },
      listenFor: Duration(seconds: 10), // Adjust for continuous listening
    );

    return true;
  }

  void stopListening() {
    speech.stop();
  }
}


// // import 'dart:math';

// import 'package:flutter/material.dart';
// // void _onPressed()
// // {

// //   print("Button Pressed");
// // }
// void main(){
//   runApp(MaterialApp( 
//     home: Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pinkAccent,
//       title: Text("Home", style: TextStyle(color: Colors.white) ,
//       ),
//       actions: <Widget>[
//         IconButton(
//           icon: const Icon(Icons.notifications),
//            onPressed: () {},
//         ),
//       ],

//       leading: IconButton(
//         onPressed: () {},
//         icon: IconButton(
//           icon: const Icon(Icons.menu),
//           onPressed: () {},

//         ),
//       ),
//       ),
//     body:Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//                   Center(
//                     child: ElevatedButton(
//                     // foregroundColor: Color(),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pinkAccent,
  
//                     ),
//                     onPressed: () {},
//                                     child: Center(
//                                       child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 20),
//                                       ),
//                                     ),
//                     ),
//                   ),
//         ],
//           ),
          
//           Row(
//             children: <Widget>[
//                   Center(
//                     child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pinkAccent,
//                     ),
//                     onPressed: () {},
//                                     child: Center(
//                                       child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 20),
//                                       ),
//                                     ),
//                     ),
//                   ),
//             ],
//           ),
//         ],
          
//       ),






//     //   body: Center(
//     //     child: ElevatedButton(
//     //     onPressed: _onPressed,
//     //       child: Text ( "Create a new Account", style: TextStyle(fontSize: 20),
//     //  ),
//     //  child: Text(data)
//     //   ),
//     //    child: Text ("or", style: TextStyle(fontSize:18 ) ,
      
//     //   ),
//     //   ),

        
// ),
//   ),
//   );
// }





// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Welcome to Women Safety App',
// //       theme: ThemeData(
// //         // This is the theme of your application.
// //         //
// //         // TRY THIS: Try running your application with "flutter run". You'll see
// //         // the application has a purple toolbar. Then, without quitting the app,
// //         // try changing the seedColor in the colorScheme below to Colors.green
// //         // and then invoke "hot reload" (save your changes or press the "hot
// //         // reload" button in a Flutter-supported IDE, or press "r" if you used
// //         // the command line to start the app).
// //         //
// //         // Notice that the counter didn't reset back to zero; the application
// //         // state is not lost during the reload. To reset the state, use hot
// //         // restart instead.
// //         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
