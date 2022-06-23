import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../store/actions/actions.dart';
import '../../store/app_state.dart';
import 'my_ads_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width / 100);
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: const Text(
                    "Profile",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "open-sans-bold"),
                  )),
              body: Column(children: [
                Container(alignment: Alignment.topCenter),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            height: 180,
                            width: width * 90,
                            child: Center(
                              child: Text(
                                state.email,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "open-sans-bold",
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xff00668f),
                        fixedSize: const Size.fromWidth(300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyAdsScreen(),
                          ));
                    },
                    child: const Text("My ads")),
                ElevatedButton(
                  child: const Text("Logout"),
                  onPressed: () {
                    StoreProvider.of<AppState>(context)
                        .dispatch(LogoutAction());
                  },
                )
              ]));
        });
  }
}
