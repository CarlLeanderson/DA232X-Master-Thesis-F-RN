import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:master_store_f/store/actions/actions.dart';
import "../../components/ad_widget.dart";
import '../../store/app_state.dart';

class MyAdsScreen extends StatelessWidget {
  const MyAdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(getAllAdsDispatch());

    Future<void> _onRefresh() async {
      StoreProvider.of<AppState>(context).dispatch(getAllAdsDispatch());
      await Future.delayed(const Duration(seconds: 2));
    }

    return (StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        List<dynamic> _userItems =
            state.allItems.where((i) => i.ownerId == state.userId).toList();
        return (Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context)),
            backgroundColor: Colors.white,
            title: const Text(
              "Ads",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "open-sans-bold"),
            ),
          ),
          body: _userItems.isEmpty
              ? const Text("You have no ads")
              : RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: (ListView.builder(
                    itemCount: _userItems.length,
                    itemBuilder: (context, index) {
                      return (ProductItem(
                          ValueKey(_userItems[index].id),
                          _userItems[index].imageUrl,
                          _userItems[index].title,
                          _userItems[index].price,
                          _userItems[index].date,
                          _userItems[index].description,
                          _userItems[index].ownerId,
                          _userItems[index].id,
                          _userItems[index].email));
                    },
                  )),
                ),
        ));
      },
    ));
  }
}
