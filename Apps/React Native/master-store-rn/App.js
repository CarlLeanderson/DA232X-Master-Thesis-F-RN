import { StatusBar } from "expo-status-bar";
import AppLoading from "expo-app-loading";
import { StyleSheet } from "react-native";
import { createStore, combineReducers, applyMiddleware } from "redux";
import ReduxThunk from "redux-thunk";
import { Provider } from "react-redux";
import itemsReducer from "./store/reducers/item";
import userReducer from "./store/reducers/login";
import * as Font from "expo-font";
import { useState } from "react";
import Navigator from "./nav/Navigator";

//Redux
const rootReducer = combineReducers({
  items: itemsReducer,
  user: userReducer,
});

//Fetch fonts
const fetchFonts = () => {
  return Font.loadAsync({
    "open-sans": require("./assets/fonts/OpenSans-Regular.ttf"),
    "open-sans-bold": require("./assets/fonts/OpenSans-Bold.ttf"),
  });
};

//Init store
const store = createStore(rootReducer, applyMiddleware(ReduxThunk));

export default function App() {
  const [fontLoaded, setFontLoaded] = useState(false);
  if (!fontLoaded) {
    return (
      <AppLoading
        startAsync={fetchFonts}
        onError={() => {
          <Text>Could not load</Text>;
        }}
        onFinish={() => {
          setFontLoaded(true);
        }}
      />
    );
  }
  return (
    <Provider store={store}>
      <Navigator />
      <StatusBar style="dark" />
    </Provider>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "center",
  },
});
