import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../elements/BlockButtonWidget.dart';
import '../elements/MobileVerificationBottomSheetWidget.dart';
import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends StateMVC<SignUpWidget> {
  UserController _con;

  _SignUpWidgetState() : super(UserController()) {
    _con = controller;
  }

  String confirmation = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _con.scaffoldKey,
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
                    child: Container(
                      width: 355.0,
                      height: 385.0,
                    ),
                  ),
                  Form(
                    key: _con.loginFormKey,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(27, 20, 27, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (input) => _con.user.name = input,
                            validator: (input) => input.length < 3
                                ? S.of(context).should_be_more_than_3_letters
                                : null,
                            decoration: InputDecoration(
                              labelText: S.of(context).full_name,
                              labelStyle: TextStyle(
                                  color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: S.of(context).john_doe,
                              hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.7)),
                              prefixIcon: Icon(Icons.person_outline,
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
                        // SizedBox(height: 30),
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
                              hintText: 'johndoe@gmail.com',
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
                        // SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.fromLTRB(27, 20, 27, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            onSaved: (input) => _con.user.phone = input,
                            validator: (input) {
                              print(input.startsWith('\+'));
                              return !input.startsWith('\+') &&
                                      !input.startsWith('00')
                                  ? "Should be valid mobile number with country code"
                                  : null;
                            },
                            decoration: InputDecoration(
                              labelText: S.of(context).phoneNumber,
                              labelStyle: TextStyle(
                                  color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: '+1 623-648-8699',
                              hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.7)),
                              prefixIcon: Icon(Icons.phone_android,
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
                        // SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.fromLTRB(27, 20, 27, 0),
                          child: TextFormField(
                            obscureText: _con.hidePassword,
                            onChanged: (value) => confirmation = value,
                            onSaved: (input) => _con.user.password = input,
                            validator: (input) => input.length < 6
                                ? S.of(context).should_be_more_than_6_letters
                                : null,
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
                                    ? Icons.visibility
                                    : Icons.visibility_off),
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(27, 20, 27, 0),
                          child: TextFormField(
                            obscureText: _con.hidePassword,
                            // onSaved: (input) => _con.user.password = input,
                            validator: (input) {
                              if (input.length < 6) {
                                return S
                                    .of(context)
                                    .should_be_more_than_6_letters;
                              }
                              if (input != confirmation) {
                                return 'The password confirmation does not match';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Confirmation',
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
                                    ? Icons.visibility
                                    : Icons.visibility_off),
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
                            splashColor: Theme.of(context).accentColor,
                            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 42.0),
                              child: Text(
                                S.of(context).register,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 25.0,
                                    fontFamily: 'WorkSansBold'),
                              ),
                            ),
                            onPressed: () {
                              if (_con.loginFormKey.currentState.validate()) {
                                _con.loginFormKey.currentState.save();
                                var bottomSheetController = _con
                                    .scaffoldKey.currentState
                                    .showBottomSheet(
                                  (context) =>
                                      MobileVerificationBottomSheetWidget(
                                          scaffoldKey: _con.scaffoldKey,
                                          user: _con.user),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                );
                                bottomSheetController.closed.then(
                                  (value) {
                                    _con.register();
                                  },
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
