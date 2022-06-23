import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import AdsNavigator from "../Ads/AdsNavigator";
import ProfileNavigator from "../Profile/ProfileNavigator";
import ImagePickerExample from "../../screens/New/NewAdScreen";
import SearchScreen from "../../screens/Search/SearchScreen";
import { FontAwesome } from "@expo/vector-icons";
import { Text } from "react-native";

const BottomTab = createBottomTabNavigator();

const BottomTabNavigator = () => {
  const DemoText = () => {
    return <Text>Temp</Text>;
  };

  return (
    <BottomTab.Navigator initialRouteName="TabOne">
      <BottomTab.Screen
        name="TabOne"
        component={AdsNavigator}
        options={({ navigation }) => ({
          title: "Ads",
          tabBarIcon: () => (
            <FontAwesome name="buysellads" size={24} color="black" />
          ),
          headerShown: false,
        })}
      />
      <BottomTab.Screen
        name="TabTwo"
        component={SearchScreen}
        options={{
          title: "Search",
          tabBarIcon: () => (
            <FontAwesome name="search" size={24} color="black" />
          ),
        }}
      />
      <BottomTab.Screen
        name="TabThree"
        component={ImagePickerExample}
        options={{
          title: "New",
          tabBarIcon: () => (
            <FontAwesome name="plus-square" size={24} color="black" />
          ),
        }}
      />
      <BottomTab.Screen
        name="TabFive"
        component={ProfileNavigator}
        options={{
          title: "Profile",
          tabBarIcon: () => <FontAwesome name="user" size={24} color="black" />,
          headerShown: false,
        }}
      />
    </BottomTab.Navigator>
  );
};
export default BottomTabNavigator;
