import 'package:actl_price/CurrencyConverterController.dart';
import 'package:actl_price/cbppage.dart';
import 'package:actl_price/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
   
  }

  final CurrencyConverterController controller = CurrencyConverterController();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/', // Set the initial route if needed
      getPages: [
        GetPage(name: '/', page: () => MyApp()), // Define your main page
        GetPage(
            name: '/cbm',
            page: () => CBMCalculatorPage()), // Define the route for CbmPage
      ],
      title: 'ACTL Calculator',
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color.fromARGB(255, 4, 4, 5),
        hintColor: const Color.fromARGB(255, 19, 20, 23),
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Currency Converter'),
          backgroundColor:
              const Color.fromARGB(255, 24, 23, 23).withOpacity(0.5),
        ),
        body: ListView(reverse: true, children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GetBuilder<CurrencyConverterController>(
              init: controller,
              builder: (controller) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      playSound();
                      // AudioPlayer().play(AssetSource('assets/gallina.mp3')); // استبدل 'audio_file.mp3' بمسار ملف الصوت الخاص بك

                      Get.toNamed('/cbm');
                    },
                    child: Lottie.asset(
                      'assets/chicken.json',
                      height: 150,
                      width: 150,
                      fit: BoxFit.fill,
                      animate: true,
                      repeat: true,
                      reverse: true,
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    controller: controller.exchangeRate,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter Exchange Rate',
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 13, 25, 72)
                          .withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: controller.amount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter Amount',
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 13, 25, 72)
                          .withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      controller.buildCurrencyDropdown(
                          label: '', currency: controller.fromCurrency),
                      InkWell(
                        onTap: () {
                          controller.switchCurrencies();
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.indigoAccent.withOpacity(0.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RotationTransition(
                              turns: Tween(begin: 0.0, end: 1.0)
                                  .animate(controller.swapAnimationController),
                              child: const Icon(
                                Icons.swap_horiz,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      controller.buildCurrencyDropdown(
                          label: '', currency: controller.toCurrency),
                    ],
                  ),
                  const SizedBox(height: 50),
                  FractionallySizedBox(
                    widthFactor: 1, // Adjust the factor as needed
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 226, 101, 52),
                      ),
                      onPressed: () {
                        controller.convertCurrency();
                      },
                      child: const Text(
                        'Convert',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  SelectableText(
                    'Converted Amount: ${controller.formatConvertedAmount()} ${controller.toCurrency}',
                    style: const TextStyle(fontSize: 21, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 100),
                  Align(
                    alignment: Alignment.topCenter,
                    child: RichText(
                      text: const TextSpan(
                        text: '© ACTL Team IT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  playSound() async {
    AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
    await audioPlayer.open(
      Audio(
        'assets/gallina.mp3',
      ),
    );
  }
  void _initializeFCM() {
  FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.instance.getToken().then((token) {
    print("FCM Token: $token");
    // Store the token on your server for sending targeted messages
  });
}
}
