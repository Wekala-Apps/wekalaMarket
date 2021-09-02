import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:wekala/src/elements/BlockButtonWidget.dart';
import '../helpers/app_config.dart' as config;
import 'package:wekala/generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../pages/login.dart';
import '../repository/user_repository.dart' as userRepo;

import '../elements/bubble_indicator_painter.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends StateMVC<LoginPage>
    with SingleTickerProviderStateMixin {
  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;
  Color center = Colors.white;

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (userRepo.currentUser.value.apiToken != null) {
      Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
    }
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            padding: EdgeInsets.only(top: 200),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[
                    Theme.of(context).accentColor,
                    Theme.of(context).primaryColor,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(2.0, 1.0),
                  stops: <double>[0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.only(top: 75.0),
                //   child: Image(
                //       height: MediaQuery.of(context).size.height > 800
                //           ? 191.0
                //           : 150,
                //       fit: BoxFit.fill,
                //       image: const AssetImage('assets/img/logo.png')),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: _buildMenuBar(context),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: PageView(
                      controller: _pageController,
                      physics: const ClampingScrollPhysics(),
                      onPageChanged: (int i) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (i == 0) {
                          setState(() {
                            right = Colors.white;
                            center = Colors.white;
                            left = Colors.black;
                          });
                        } else if (i == 1) {
                          setState(() {
                            right = Colors.white;
                            center = Colors.black;
                            left = Colors.white;
                          });
                        } else if (i == 2) {
                          setState(() {
                            right = Colors.black;
                            center = Colors.white;
                            left = Colors.white;
                          });
                        }
                      },
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: LoginWidget(),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: SignUpWidget(),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: LoginWidget(),
                          // Container(
                          //   child: Text('phone login'),
                          // ),
                          // const SignUp(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 355.0,
      height: 50.0,
      decoration: const BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: BubbleIndicatorPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: _onSignInButtonPress,
                child: Text(
                  'Existing',
                  style: TextStyle(
                      color: left,
                      fontSize: 16.0,
                      fontFamily: 'WorkSansSemiBold'),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: _onSignUpButtonPress,
                child: Text(
                  'New',
                  style: TextStyle(
                      color: center,
                      fontSize: 16.0,
                      fontFamily: 'WorkSansSemiBold'),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: _onPhoneLoginButtonPress,
                child: Text(
                  'Other',
                  style: TextStyle(
                      color: right,
                      fontSize: 16.0,
                      fontFamily: 'WorkSansSemiBold'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onPhoneLoginButtonPress() {
    _pageController?.animateToPage(2,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
