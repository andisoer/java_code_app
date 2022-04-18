import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/page/login_page.dart';
import 'package:java_code_app/provider/auth_provider.dart';
import 'package:java_code_app/provider/profile_provider.dart';
import 'package:java_code_app/style/colors.dart';
import 'package:java_code_app/style/style.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
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
                      margin: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/circle_profile.png'),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/identity.png'),
                                Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    'Verifikasi KTP mu sekarang!',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      color: primaryColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: Text(
                              'Info Akun',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          _buildAccountInfo(),
                          _buildRatingInfo(),
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: Text(
                              'Info Lainnya',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          _builtOtherInfo(context),
                          _buildLogoutButton(context)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _builtOtherInfo(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: const Color.fromRGBO(246, 246, 246, 1),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 2,
            color: Colors.grey.withAlpha(70),
          )
        ],
      ),
      child: Consumer<ProfileProvider>(
        builder: (context, state, _) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Device Info',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        state.deviceInfo,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
              buildHorizontalBorder(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Version',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '1.3',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Row _buildLogoutButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: ElevatedButton(
            onPressed: () {
              logout(context);
            },
            child: Text(
              'Log out',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
              ),
              primary: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 64),
              side: const BorderSide(
                color: Color.fromARGB(255, 0, 113, 127),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container _buildRatingInfo() {
    return Container(
      margin: const EdgeInsets.only(top: 18),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: const Color.fromRGBO(246, 246, 246, 1),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 2,
            color: Colors.grey.withAlpha(70),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/images/bubble_rating.png'),
              Container(
                margin: const EdgeInsets.only(left: 8),
                child: Text(
                  'Penilaian',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildAccountInfo() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: const Color.fromRGBO(246, 246, 246, 1),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 2,
            color: Colors.grey.withAlpha(70),
          )
        ],
      ),
      child: Consumer<ProfileProvider>(
        builder: (context, state, _) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nama',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Fajar',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
              buildHorizontalBorder(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tanggal Lahir',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '01/03/1993',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              buildHorizontalBorder(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'No.Telepon',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '0822-4111-400',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
              buildHorizontalBorder(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Email',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'lorem.ipsum@gmail.com',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
              buildHorizontalBorder(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ubah PIN',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '*******',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
              buildHorizontalBorder(),
              Container(
                margin: const EdgeInsets.only(bottom: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ganti Bahasa',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Indonesia',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 4),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Container _buildAppBar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 66,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: appBarDecoration(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Profile',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  void logout(BuildContext context) {
    clearPreferences().then(
      (loggedOut) => {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginPage.routeName,
          (route) => false,
        )
      },
    );
  }
}
