import * as React from "react";
import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import BottomTabNavigator from "./BottomTab/BottomTabNavigator";
import LoginScreen from "../screens/LoginScreen";
import { useSelector } from "react-redux";

const Stack = createNativeStackNavigator();

const RootNavigator = () => {
  return (
    <Stack.Navigator>
      <Stack.Screen
        name="Root"
        component={BottomTabNavigator}
        options={{ headerShown: false }}
      />
    </Stack.Navigator>
  );
};
//<RootNavigator />
const Navigator = () => {
  const token = useSelector((state) => state.user.token);
  return (
    <NavigationContainer>
      {token ? <RootNavigator /> : <LoginScreen />}
    </NavigationContainer>
  );
};

export default Navigator;
