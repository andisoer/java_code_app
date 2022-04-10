import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:java_code_app/page/check_location.dart';
import 'package:java_code_app/page/no_internet.dart';
import 'package:java_code_app/provider/auth_provider.dart';
import 'package:java_code_app/provider/internet_connection_provider.dart';
import 'package:java_code_app/style/colors.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;

  var email = "";
  var password = "";
  var nama = "";
  var isGoogle = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/pattern.png',
                    scale: 1.2,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 46),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/java_code_logo.png',
                        scale: 1.2,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 96),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Masuk untuk melanjutkan!',
                              style: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 32),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alamat email',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextField(
                        onChanged: (value) => email = value,
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.montserrat(
                          color: const Color.fromARGB(174, 30, 30, 30),
                        ),
                        decoration: InputDecoration(
                          hintText: "your@email.com",
                          hintStyle: GoogleFonts.montserrat(
                            color: const Color.fromARGB(70, 30, 30, 30),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 32),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kata Sandi',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextField(
                        onChanged: (value) => password = value,
                        style: GoogleFonts.montserrat(
                          color: const Color.fromARGB(174, 30, 30, 30),
                        ),
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color.fromARGB(70, 0, 0, 0),
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          hintText: "••••••••",
                          hintStyle: GoogleFonts.montserrat(
                            color: const Color.fromARGB(70, 30, 30, 30),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 32),
                        child: ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          child: Consumer<AuthProvider>(
                            builder: (context, state, _) {
                              if (state.resourceState ==
                                  ResourceState.loading) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                );
                              } else if (state.resourceState ==
                                  ResourceState.success) {
                                WidgetsBinding.instance?.addPostFrameCallback(
                                  (timeStamp) {
                                    Navigator.popAndPushNamed(
                                        context, CheckLocationPage.routeName);
                                  },
                                );
                                return Text(
                                  "Masuk",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                );
                              } else {
                                return Text(
                                  "Masuk",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                );
                              }
                            },
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            primary: primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            minimumSize: const Size.fromHeight(40),
                            side: const BorderSide(
                              color: Color.fromARGB(255, 0, 113, 127),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 40, bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                children: const [
                                  Divider(
                                    color: Color.fromARGB(70, 30, 30, 30),
                                    height: 1,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: const Text(
                                "atau",
                                style: TextStyle(
                                  color: Color.fromARGB(70, 30, 30, 30),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: const [
                                  Divider(
                                    color: Color.fromARGB(70, 30, 30, 30),
                                    height: 1,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          isInternetConnected().then((internetConnected) {
                            if (internetConnected) {
                              loginWithGoogle();
                            } else {
                              Navigator.pushNamed(
                                context,
                                NoInternetPage.routeName,
                              );
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/google_icon.png"),
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "Masuk menggunakan",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          const Color.fromARGB(255, 30, 30, 30),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 2),
                                    child: Text(
                                      "Google",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: const Color.fromARGB(
                                          255,
                                          30,
                                          30,
                                          30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(24),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          minimumSize: const Size.fromHeight(40),
                          primary: Colors.white,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 14),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/apple_icon.png"),
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      "Masuk menggunakan",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 2),
                                      child: Text(
                                        "Apple",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 30, 30, 30),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            minimumSize: const Size.fromHeight(40),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginWithGoogle() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
  }

  void login() {
    isInternetConnected().then((internetConnected) {
      if (internetConnected) {
        Provider.of<AuthProvider>(context, listen: false).login(
          nama: "",
          password: password,
          email: email,
          isGoogle: false,
        );
      } else {
        Navigator.pushNamed(context, NoInternetPage.routeName);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _isPasswordVisible = true;
    _googleSignIn.onCurrentUserChanged.listen(
      (GoogleSignInAccount? account) {
        if (account != null) {
          isGoogle = true;
          nama = account.displayName!;
          email = account.email;
          Provider.of<AuthProvider>(context, listen: false).login(
            nama: nama,
            password: "",
            email: email,
            isGoogle: true,
          );
        }
      },
    );
  }
}
