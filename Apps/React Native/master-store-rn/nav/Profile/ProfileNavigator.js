import { createNativeStackNavigator } from "@react-navigation/native-stack";
import ProfileScreen from "../../screens/Profile/ProfileScreen";
import MyAdsScreen from "../../screens/Profile/MyAdsScreen";
const ProfileStack = createNativeStackNavigator();

const ProfileNavigator = () => {
  return (
    <ProfileStack.Navigator initialRouteName="Profile">
      <ProfileStack.Screen
        name="AdsScreen"
        component={ProfileScreen}
        options={{ title: "Profile" }}
      />
      <ProfileStack.Screen
        name="MyAdsScreen"
        component={MyAdsScreen}
        options={{ title: "My ads" }}
      />
    </ProfileStack.Navigator>
  );
};

export default ProfileNavigator;
