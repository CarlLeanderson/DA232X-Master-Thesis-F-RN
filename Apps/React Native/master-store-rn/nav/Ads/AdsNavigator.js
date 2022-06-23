import { createNativeStackNavigator } from "@react-navigation/native-stack";
import AdsScreen from "../../screens/Ads/AdsScreen";
import ViewAdScreen from "../../screens/Ads/ViewAdScreen";
const AdsStack = createNativeStackNavigator();

const AdsNavigator = () => {
  return (
    <AdsStack.Navigator initialRouteName="Ads">
      <AdsStack.Screen
        name="AdsScreen"
        component={AdsScreen}
        options={{ title: "Ads" }}
      />
      <AdsStack.Screen
        name="ViewAdScreen"
        component={ViewAdScreen}
        options={({ route }) => ({ title: route.params.title })}
      />
    </AdsStack.Navigator>
  );
};

export default AdsNavigator;
