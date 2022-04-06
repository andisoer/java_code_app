import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  _NoInternetPageState createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  bool internetConnected = false;
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: internetConnected
            ? const Text("Internet connected")
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/server_down.png'),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Koneksi anda terputus, \nsilahkan cek koneksi anda',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        setState(() {
          internetConnected = true;
        });
      } else if (result == ConnectivityResult.wifi) {
        setState(() {
          internetConnected = true;
        });
      } else if (result == ConnectivityResult.none) {
        setState(() {
          internetConnected = false;
        });
      } else {
        setState(() {
          internetConnected = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }
}
