import React, { useCallback, useState } from "react";
import {
  ScrollView,
  View,
  StyleSheet,
  Text,
  TextInput,
  Button,
  SafeAreaView,
} from "react-native";
import { useDispatch, useSelector } from "react-redux";
import * as loginActions from "../store/actions/login";
import CustomButton from "../components/CustomButton";

const LoginScreen = () => {
  const dispatch = useDispatch();
  const [username, setUserName] = useState("");
  const [password, setPassword] = useState("");
  const signupStatus = useSelector((state) => state.user.signupStatus);

  const loginHandler = async () => {
    if (username === "" || password === "") {
      alert("Please enter all required fields");
      return;
    }
    let action = "";
    if (signupStatus) {
      action = loginActions.signup(username, password);
    } else {
      action = loginActions.login(username, password);
    }
    try {
      await dispatch(action);
      dispatch(loginActions.signupStatus(false));
    } catch (err) {
      alert(err);
      dispatch(loginActions.signupStatus(false));
    }
  };
  return (
    <SafeAreaView style={styles.screen}>
      <View style={styles.container}>
        <Text style={styles.titleText}>React Native</Text>
        <ScrollView>
          <Text>Username</Text>
          <TextInput
            style={styles.searchBar}
            onChangeText={(usr) => {
              setUserName(usr);
            }}
          ></TextInput>
          <Text>Password</Text>
          <TextInput
            secureTextEntry={true}
            style={styles.searchBar}
            onChangeText={(psw) => {
              setPassword(psw);
            }}
          ></TextInput>
          {signupStatus ? (
            <CustomButton onPress={loginHandler} title={"Signup"} />
          ) : (
            <CustomButton onPress={loginHandler} title={"Login"} />
          )}
          <Button
            title="Switch to signup"
            onPress={() => {
              if (signupStatus) {
                dispatch(loginActions.signupStatus(false));
                return;
              }
              dispatch(loginActions.signupStatus(true));
            }}
          />
        </ScrollView>
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  container: {
    width: "80%",
    maxWidth: 400,
  },
  searchBar: {
    fontSize: 14,
    margin: "5%",
    width: "90%",
    height: 30,
    backgroundColor: "#e8e8e8",
    borderRadius: 10,
  },
  titleText: {
    fontSize: 20,
    textAlign: "center",
    marginVertical: 20,
    fontFamily: "open-sans-bold",
  },
});

export default LoginScreen;
