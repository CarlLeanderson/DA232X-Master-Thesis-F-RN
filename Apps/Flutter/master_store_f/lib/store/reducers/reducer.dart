import "../app_state.dart";

AppState adReducer(AppState prevState, action) {
  switch (action.type) {
    case "GET_ADS":
      return prevState.copyWith(allItems: action.ads);
    case "REMOVE_AD":
      List<dynamic> ads;
      if (prevState.allItems.length == 1) {
        ads = [];
      } else {
        ads = prevState.allItems.where((item) => item.id != action.id).toList();
      }
      return prevState.copyWith(allItems: ads);
    case "UPLOADING":
      return prevState.copyWith(isUploading: action.isUploading);

    case "SIGNUP_STATUS":
      return prevState.copyWith(signupStatus: action.signupStatus);

    case "LOGIN":
      return prevState.copyWith(
          token: action.idToken, userId: action.localId, email: action.email);

    case "UPLOAD_PROGRESS":
      return prevState.copyWith(uploadStatus: action.progress);

    case "LOGOUT":
      return prevState.copyWith(token: "");
  }
  return prevState;
}
