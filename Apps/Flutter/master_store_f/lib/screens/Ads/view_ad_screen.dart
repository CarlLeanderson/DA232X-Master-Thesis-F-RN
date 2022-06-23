import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../store/actions/actions.dart';
import '../../store/app_state.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewAdScreen extends StatefulWidget {
  const ViewAdScreen(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.price,
      required this.date,
      required this.description,
      required this.ownerId,
      required this.id,
      required this.email})
      : super(key: key);

  final String imageUrl;
  final String title;
  final int price;
  final String date;
  final String description;
  final String ownerId;
  final String id;
  final String email;

  @override
  State<ViewAdScreen> createState() => _ViewAdScreenState();
}

class _ViewAdScreenState extends State<ViewAdScreen> {
  Future<void> _simulatorError() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Feature alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This feature only works on a physical device.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Uri _url =
        Uri.parse('mailto:${widget.email}?subject=${widget.title}');

    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return (Scaffold(
              appBar: AppBar(
                  leading: const BackButton(color: Colors.black),
                  backgroundColor: Colors.white,
                  title: Text(
                    widget.title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "open-sans-bold"),
                  )),
              body: Column(children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(children: [
                    Text("Price: " + widget.price.toString() + "kr"),
                    Text(widget.description),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xff00668f),
                          fixedSize: const Size.fromWidth(300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                      onPressed: () async {
                        if (!await launchUrl(_url)) {
                          _simulatorError();
                        }
                      },
                      child: const Text("Message seller")),
                ),
                state.userId == widget.ownerId
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xffb30c00),
                                fixedSize: const Size.fromWidth(300),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                            onPressed: () async {
                              StoreProvider.of<AppState>(context)
                                  .dispatch(removeAd(widget.id));
                              await Future.delayed(const Duration(seconds: 2));
                              Navigator.pop(context);
                            },
                            child: const Text("Remove")),
                      )
                    : const Text("")
              ])));
        });
  }
}
