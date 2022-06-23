import 'dart:io';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/ad.dart';
import '../app_state.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';

//Database reference
firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;
FirebaseDatabase database = FirebaseDatabase.instance;

//Upload ad
ThunkAction<AppState> uploadFileAndAd(String description, String email,
    String filePath, String ownerId, int price, String title) {
  return (Store<AppState> store) async {
    File file = File(filePath);

    String fileRef = DateTime.now().toString();

    try {
      firebase_storage.UploadTask task = firebase_storage
          .FirebaseStorage.instance
          .ref('images/$fileRef.jpg')
          .putFile(file);
      task.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
        store.dispatch(UploadProgressAction(
            ((snapshot.bytesTransferred / snapshot.totalBytes) * 100)));
      });

      try {
        await task;
        String downloadURL = await firebase_storage.FirebaseStorage.instance
            .ref('images/$fileRef.jpg')
            .getDownloadURL();
        store.dispatch(uploadAdDispatch(
            fileRef, description, email, downloadURL, ownerId, price, title));
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  };
}

//Remove ad
ThunkAction<AppState> removeAd(id) {
  return (Store<AppState> store) async {
    await http.delete(Uri.parse('Insert here/ads/$id.json'));
    store.dispatch(RemoveAdAction(id));
  };
}

//Middleware for fetching Ads from database
ThunkAction<AppState> getAllAdsDispatch() {
  return (Store<AppState> store) async {
    List<dynamic> ads = [];
    final url = Uri.https('Insert here', '/ads.json');
    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    jsonData.forEach((key, value) {
      ads.add(Ad(
          date: jsonData[key]['date'],
          description: jsonData[key]['description'],
          email: jsonData[key]['email'],
          id: key,
          imageUrl: jsonData[key]['imageURL'],
          ownerId: jsonData[key]['ownerId'],
          price: jsonData[key]['price'],
          title: jsonData[key]['title']));
    });
    store.dispatch(GetAdsAction(ads));
  };
}

//Login user and get token
ThunkAction<AppState> login(String email, String password) {
  return (Store<AppState> store) async {
    final url = Uri.parse('Insert here');
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    final responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      print(responseData['error']['message']);
    } else {
      store.dispatch(LoginAction(responseData['idToken'],
          responseData['localId'], responseData['email']));
    }
  };
}

//Login user and get token
ThunkAction<AppState> signup(String email, String password) {
  return (Store<AppState> store) async {
    final url = Uri.parse('Insert here');
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    final responseData = json.decode(response.body);
    if (responseData['error'] != null) {
    } else {
      store.dispatch(LoginAction(responseData['idToken'],
          responseData['localId'], responseData['email']));
    }
  };
}

//Upload ad to firebase
ThunkAction<AppState> uploadAdDispatch(String date, String description,
    String email, String imageUrl, String ownerId, int price, String title) {
  return (Store<AppState> store) async {
    final url = Uri.https('Insert here', '/ads.json');
    Map<String, String> requestHeaders = {'Content-type': 'application/json'};

    Map data = {
      "date": date,
      "description": description,
      "email": email,
      "imageURL": imageUrl,
      "ownerId": ownerId,
      "price": price,
      "title": title
    };
    final response =
        await http.post(url, body: jsonEncode(data), headers: requestHeaders);
    store.dispatch(getAllAdsDispatch());
  };
}

class LoginAction {
  String type = "LOGIN";
  String idToken;
  String localId;
  String email;
  LoginAction(this.idToken, this.localId, this.email);
}

class LogoutAction {
  String type = "LOGOUT";
  LogoutAction();
}

class UploadProgressAction {
  String type = "UPLOAD_PROGRESS";
  double progress;
  UploadProgressAction(this.progress);
}

class GetAdsAction {
  String type = "GET_ADS";
  List<dynamic> ads;
  GetAdsAction(this.ads);
}

class RemoveAdAction {
  String type = "REMOVE_AD";
  String id;
  RemoveAdAction(this.id);
}

class UploadingAction {
  String type = "UPLOADING";
  bool isUploading;
  UploadingAction(this.isUploading);
}

class SignUpStatus {
  String type = "SIGNUP_STATUS";
  bool signupStatus;
  SignUpStatus(this.signupStatus);
}
