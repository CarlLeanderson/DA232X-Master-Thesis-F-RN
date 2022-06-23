import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:master_store_f/store/actions/actions.dart';
import '../../store/app_state.dart';
import '../nav/navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";

  _changeEmail(text) {
    setState(() {
      email = text;
    });
  }

  _changePass(text) {
    setState(() {
      password = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (StoreConnector<AppState, bool>(
      converter: (store) => store.state.signupStatus,
      builder: (_, signupStatus) {
        return (Scaffold(
            body: SafeArea(
                child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: const Text("Flutter",
                        style: TextStyle(
                            fontSize: 20, fontFamily: "open-sans-bold"))),
                Container(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 15),
                    alignment: Alignment.centerLeft,
                    child: const Text("Username")),
                SizedBox(
                  height: 30.0,
                  width: 300.0,
                  child: TextFormField(
                      onChanged: (text) => _changeEmail(text),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xffe8e8e8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              )))),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(30, 15, 0, 10),
                    alignment: Alignment.centerLeft,
                    child: const Text("Password")),
                SizedBox(
                  height: 30.0,
                  width: 300.0,
                  child: TextFormField(
                      obscureText: true,
                      onChanged: (text) => _changePass(text),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xffe8e8e8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              )))),
                ),
                signupStatus
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xff00668f),
                                fixedSize: const Size.fromWidth(300),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                            onPressed: () {
                              StoreProvider.of<AppState>(context)
                                  .dispatch(signup(email, password));
                            },
                            child: const Text("Signup")),
                      )
                    : Container(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xff00668f),
                                fixedSize: const Size.fromWidth(300),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                            onPressed: () {
                              StoreProvider.of<AppState>(context)
                                  .dispatch(login(email, password));
                            },
                            child: const Text("Login")),
                      ),
                signupStatus
                    ? (ElevatedButton(
                        onPressed: () {
                          StoreProvider.of<AppState>(context)
                              .dispatch(SignUpStatus(false));
                        },
                        child: const Text("Switch to login")))
                    : ElevatedButton(
                        onPressed: () {
                          StoreProvider.of<AppState>(context)
                              .dispatch(SignUpStatus(true));
                        },
                        child: const Text("Switch to signup"))
              ]),
        ))));
      },
    ));
  }
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (StoreConnector<AppState, String>(
      converter: (store) => store.state.token,
      builder: (_, token) {
        return token == "" ? const LoginScreen() : const Navigation();
      },
    ));
  }
}
