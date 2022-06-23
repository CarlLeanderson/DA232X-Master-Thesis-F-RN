import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:master_store_f/store/actions/actions.dart';
import '../../store/app_state.dart';

class CreateNewAdScreen extends StatefulWidget {
  const CreateNewAdScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewAdScreen> createState() => _CreateNewAdScreen();
}

class _CreateNewAdScreen extends State<CreateNewAdScreen> {
  final titleText = TextEditingController();
  final descriptionText = TextEditingController();
  final priceText = TextEditingController();

  File? _image;
  String title = "";
  String description = "";
  int price = 0;

  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  _clear() {
    titleText.clear();
    descriptionText.clear();
    priceText.clear();
    setState(() {
      _image = null;
      title = "";
      description = "";
      price = 0;
    });
  }

  onChangedHandler(String text) {
    setState(() {});
  }

  _setTitle(String text) {
    setState(() {
      title = text;
    });
  }

  _setDescription(String text) {
    setState(() {
      description = text;
    });
  }

  _setPrice(String text) {
    setState(() {
      price = int.parse(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return (Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                title: const Text("New",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "open-sans-bold"))),
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          child: const Text(
                            "Create New Ad",
                            style: TextStyle(
                                fontSize: 20, fontFamily: "open-sans-bold"),
                          ),
                        )),
                    Container(
                        padding: const EdgeInsets.all(20.0),
                        alignment: Alignment.topLeft,
                        child: const Text("Title",
                            style: TextStyle(fontFamily: "open-sans-bold"))),
                    SizedBox(
                      height: 30.0,
                      width: 350.0,
                      child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(10.0),
                        shadowColor: Colors.black,
                        child: TextFormField(
                            controller: titleText,
                            onChanged: (text) => _setTitle(text),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    )))),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(20.0),
                        alignment: Alignment.topLeft,
                        child: const Text("Description",
                            style: TextStyle(fontFamily: "open-sans-bold"))),
                    SizedBox(
                      height: 30.0,
                      width: 350.0,
                      child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(10.0),
                        shadowColor: Colors.black,
                        child: TextFormField(
                            controller: descriptionText,
                            onChanged: (text) => _setDescription(text),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    )))),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(20.0),
                        alignment: Alignment.topLeft,
                        child: const Text("Price",
                            style: TextStyle(fontFamily: "open-sans-bold"))),
                    SizedBox(
                      height: 30.0,
                      width: 350.0,
                      child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(10.0),
                        shadowColor: Colors.black,
                        child: TextFormField(
                            controller: priceText,
                            onChanged: (text) => _setPrice(text),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    )))),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 100,
                      child: _image != null
                          ? Image.file(_image!, fit: BoxFit.cover)
                          : const Text('Please select an image'),
                    ),
                    ElevatedButton(
                      child: const Text('Select An Image'),
                      onPressed: _openImagePicker,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xff00668f),
                              fixedSize: const Size.fromWidth(350),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          onPressed: () => {
                                if (description != "" &&
                                    title != "" &&
                                    price != 0)
                                  {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          _buildPopupDialog(context),
                                    ),
                                    StoreProvider.of<AppState>(context)
                                        .dispatch(uploadFileAndAd(
                                            description,
                                            state.email,
                                            _image!.path,
                                            state.userId,
                                            price,
                                            title))
                                  }
                              },
                          child: const Text("Save")),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                          onPressed: _clear, child: const Text("Clear")),
                    )
                  ],
                ),
              ],
            ),
          ));
        });
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return AlertDialog(
          title: const Text('Uploading'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(state.uploadStatus.toStringAsFixed(2)),
            ],
          ),
          actions: <Widget>[
            state.uploadStatus.toStringAsFixed(2) == "100.00"
                ? (ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ))
                : const Text(""),
          ],
        );
      });
}
