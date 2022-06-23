import 'package:redux/redux.dart';
import '../store/app_state.dart';
import '../store/reducers/reducer.dart';
import "package:redux_thunk/redux_thunk.dart";

final store = Store<AppState>(adReducer,
    middleware: [thunkMiddleware], initialState: AppState.initialState());
