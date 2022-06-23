import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:master_store_f/store/actions/actions.dart';
import "../../components/ad_widget.dart";
import '../../store/app_state.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(getAllAdsDispatch());

    Future<void> _onRefresh() async {
      StoreProvider.of<AppState>(context).dispatch(getAllAdsDispatch());
      await Future.delayed(const Duration(seconds: 2));
    }

    return (StoreConnector<AppState, List>(
      converter: (store) => store.state.allItems,
      builder: (_, state) {
        return (Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text(
                "Ads",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: "open-sans-bold"),
              )),
          body: state.isEmpty
              ? const Text("No ads available")
              : RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: (ListView.builder(
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      return (ProductItem(
                          ValueKey(state[index].id),
                          state[index].imageUrl,
                          state[index].title,
                          state[index].price,
                          state[index].date,
                          state[index].description,
                          state[index].ownerId,
                          state[index].id,
                          state[index].email));
                    },
                  )),
                ),
        ));
      },
    ));
  }
}
