import React from "react";
import { Text, Image, StyleSheet, View, ScrollView } from "react-native";
import { useSelector, useDispatch } from "react-redux";
import CustomButton from "../../components/CustomButton";
import { removeAd } from "../../firebase/firebaseDatabase";
import * as itemActions from "../../store/actions/items";
import * as Device from "expo-device";
import * as MailComposer from "expo-mail-composer";

const ViewAdScreen = ({ route, navigation }) => {
  const dispatch = useDispatch();
  const userId = useSelector((state) => state.user.userId);
  const { itemId } = route.params;
  route.params;
  const selectedItem = useSelector((state) =>
    state.items.allItems.find((item) => item.id === itemId)
  );

  const onPressHandler = () => {
    const MailComposerOptions = {
      recipients: [selectedItem.email],
    };
    if (Device.isDevice) {
      MailComposer.composeAsync(MailComposerOptions);
    } else {
      alert("This feature only works on a real device");
    }
  };

  const onPressHandlerRemove = () => {
    if (removeAd(itemId)) {
      setTimeout(() => {
        dispatch(itemActions.getAds()).then(() => {
          navigation.goBack();
        });
      }, 1000);
    }
  };

  return (
    <ScrollView style={styles.main}>
      {selectedItem ? (
        <View>
          <Image style={styles.image} source={{ uri: selectedItem.imageUrl }} />
          <Text style={styles.price}>{selectedItem.price}</Text>
          <Text style={styles.description}>{selectedItem.description}</Text>
          <View style={styles.actions}>
            {selectedItem.ownerId === userId ? (
              <CustomButton
                color={"#b30c00"}
                title={"Remove Ad"}
                onPress={onPressHandlerRemove}
              />
            ) : (
              <CustomButton title={"Message seller"} onPress={onPressHandler} />
            )}
          </View>
        </View>
      ) : (
        <Text>Could not load ad</Text>
      )}
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  main: {
    backgroundColor: "white",
    height: "100%",
  },
  image: { width: "100%", height: "100%", height: 300 },
  price: {
    fontSize: 20,
    color: "#888",
    textAlign: "center",
    marginVertical: 20,
    fontFamily: "open-sans-bold",
  },
  description: {
    fontSize: 14,
    textAlign: "center",
    marginHorizontal: 20,
    fontFamily: "open-sans",
  },
  actions: {
    marginVertical: 10,
    alignItems: "center",
  },
});
export default ViewAdScreen;
