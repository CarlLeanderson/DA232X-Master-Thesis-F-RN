import React from "react";
import {
  View,
  Text,
  Image,
  StyleSheet,
  Button,
  TouchableOpacity,
  Platform,
} from "react-native";
import * as loginActions from "../../store/actions/login";
import { useSelector, useDispatch } from "react-redux";
import CustomButton from "../../components/CustomButton";

const ProfileScreen = ({ navigation }) => {
  const email = useSelector((state) => state.user.email);
  const dispatch = useDispatch();
  const _logout = () => {
    dispatch(loginActions.logout());
  };

  return (
    <View style={styles.main}>
      <View style={styles.product}>
        <Text style={styles.title}>{email}</Text>
      </View>
      <CustomButton
        title="My Ads"
        onPress={() => {
          navigation.navigate("MyAdsScreen", {
            itemId: "p1",
            title: "My Ads",
          });
        }}
      />
      <Button title="Logout" styles={styles.actions} onPress={_logout} />
    </View>
  );
};

const styles = StyleSheet.create({
  main: {
    backgroundColor: "white",
    height: "100%",
  },
  product: {
    shadowColor: "black",
    shadowOpacity: 0.26,
    shadowOffset: { width: 0, height: 2 },
    //For iOS
    shadowRadius: 8,
    //Elevation for android
    elevation: 5,
    borderRadius: 10,
    backgroundColor: "white",
    height: 200,
    margin: 20,
  },
  image: {
    width: "100%",
    height: "100%",
  },
  title: {
    fontSize: 20,
    textAlign: "center",
    marginVertical: "25%",
    fontFamily: "open-sans-bold",
  },
  price: {
    fontSize: 14,
    color: "#888",
    fontFamily: "open-sans",
  },
  actions: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    height: "20%",
    padding: 10,
  },
  details: {
    alignItems: "center",
    height: "20%",
    padding: 10,
  },
  imageContainer: {
    width: "100%",
    height: "60%",
    borderTopLeftRadius: 10,
    borderTopRightRadius: 10,
    overflow: "hidden",
  },
  touchable: {
    borderRadius: 10,
    overflow: "hidden",
  },
});

export default ProfileScreen;
