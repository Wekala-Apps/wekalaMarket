import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../helpers/helper.dart';
import '../repository/user_repository.dart' as userRepo;

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends StateMVC<LoginWidget> {
  UserController _con;

  _LoginWidgetState() : super(UserController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
    if (userRepo.currentUser.value.apiToken != null) {
      Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: _con.scaffoldKey,
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: Container(
          padding: const EdgeInsets.only(top: 23.0),
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Card(
                    elevation: 2.0,
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: SizedBox(
                      height: 190.0,
                      width: 355.0,
                    ),
                  ),
                  Form(
                    key: _con.loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(27, 20, 27, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (input) => _con.user.email = input,
                            validator: (input) => !input.contains('@')
                                ? S.of(context).should_be_a_valid_email
                                : null,
                            decoration: InputDecoration(
                              labelText: S.of(context).email,
                              labelStyle: TextStyle(
                                  color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: 'Email@test.com',
                              hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.7)),
                              prefixIcon: Icon(Icons.alternate_email,
                                  color: Theme.of(context).accentColor),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.5))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.2))),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(27, 20, 27, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (input) => _con.user.password = input,
                            validator: (input) => input.length < 3
                                ? S.of(context).should_be_more_than_3_characters
                                : null,
                            obscureText: _con.hidePassword,
                            decoration: InputDecoration(
                              labelText: S.of(context).password,
                              labelStyle: TextStyle(
                                  color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: '••••••••••••',
                              hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.7)),
                              prefixIcon: Icon(Icons.lock_outline,
                                  color: Theme.of(context).accentColor),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _con.hidePassword = !_con.hidePassword;
                                  });
                                },
                                color: Theme.of(context).focusColor,
                                icon: Icon(_con.hidePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.5))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.2))),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Theme.of(context).primaryColor,
                                offset: Offset(1.0, 6.0),
                                blurRadius: 20.0,
                              ),
                              BoxShadow(
                                color: Theme.of(context).accentColor,
                                offset: Offset(1.0, 6.0),
                                blurRadius: 20.0,
                              ),
                            ],
                            gradient: LinearGradient(
                                colors: <Color>[
                                  Theme.of(context).accentColor,
                                  Theme.of(context).accentColor,
                                ],
                                begin: FractionalOffset(0.2, 0.2),
                                end: FractionalOffset(1.0, 1.0),
                                stops: <double>[0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Theme.of(context).primaryColor,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 42.0),
                              child: Text(
                                S.of(context).login.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontFamily: 'WorkSansBold'),
                              ),
                            ),
                            onPressed: () {
                              _con.login();
                              Navigator.of(context)
                                  .pushReplacementNamed('/Pages', arguments: 2);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/Pages', arguments: 2);
                  },
                  child: Text(
                    S.of(context).skip,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).hintColor,
                        fontSize: 16.0,
                        fontFamily: 'WorkSansMedium'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[
                              Theme.of(context).highlightColor,
                              Theme.of(context).hintColor,
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 1.0),
                            stops: <double>[0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      width: 100.0,
                      height: 1.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        'Or',
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: 16.0,
                            fontFamily: 'WorkSansMedium'),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[
                              Theme.of(context).hintColor,
                              Theme.of(context).highlightColor,
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 1.0),
                            stops: <double>[0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      width: 100.0,
                      height: 1.0,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 40.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Icon(
                          FontAwesomeIcons.facebookF,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        _con.loginGoogle();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Icon(
                          FontAwesomeIcons.google,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/ForgetPassword');
                  },
                  child: Text(
                    S.of(context).i_forgot_password,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).hintColor,
                        fontSize: 16.0,
                        fontFamily: 'WorkSansMedium'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
