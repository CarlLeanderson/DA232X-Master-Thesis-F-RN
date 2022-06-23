import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import "../../components//ad_widget.dart";
import '../../store/app_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  List<dynamic> searchResult = [];

  @override
  Widget build(BuildContext context) {
    return (StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text("Search",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "open-sans-bold"))),
          body: Column(
            children: [
              Container(
                height: 100,
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(6),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10.0),
                  shadowColor: Colors.black,
                  child: TextFormField(
                    onChanged: (text) => {
                      searchResult = state.allItems
                          .where((item) => item.title
                              .toLowerCase()
                              .contains(text.toLowerCase()))
                          .toList(),
                      setState(() {
                        searchResult = searchResult;
                      })
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ))),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: searchResult.length,
                  itemBuilder: (context, index) {
                    return (ProductItem(
                        null,
                        searchResult[index].imageUrl,
                        searchResult[index].title,
                        searchResult[index].price,
                        searchResult[index].date!,
                        searchResult[index].description!,
                        searchResult[index].ownerId,
                        searchResult[index].id,
                        searchResult[index].email));
                  },
                ),
              )
            ],
          ),
        );
      },
    ));
  }
}
