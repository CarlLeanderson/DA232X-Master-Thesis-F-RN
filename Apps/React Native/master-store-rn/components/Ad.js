import React from "react";
import {
  View,
  Text,
  Image,
  StyleSheet,
  TouchableOpacity,
  Platform,
  TouchableNativeFeedback,
} from "react-native";

//Android animation looks off otherwise
let TouchableItem = TouchableOpacity;

if (Platform.OS === "android" && Platform.Version >= 21) {
  TouchableItem = TouchableNativeFeedback;
}

const ProductItem = (props) => {
  return (
    <View style={styles.product}>
      <View style={styles.touchable}>
        <TouchableItem onPress={props.onViewDetail} useForeground>
          <View>
            <View style={styles.imageContainer}>
              <Image style={styles.image} source={{ uri: props.image }} />
            </View>
            <View style={styles.section}>
              <View style={styles.details}>
                <Text style={styles.title}>{props.title}</Text>
                <Text style={styles.price}>{props.price}kr</Text>
              </View>
              <View style={styles.date}>
                <Text>{props.date}</Text>
              </View>
            </View>
          </View>
        </TouchableItem>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  product: {
    shadowColor: "black",
    backgroundColor: "white",
    borderRadius: 10,
    shadowColor: "black",
    shadowOpacity: 0.16,
    shadowOffset: { width: 0, height: 1 },
    //For iOS
    shadowRadius: 2,
    //Elevation for android
    elevation: 5,
    backgroundColor: "white",
    height: 200,
    margin: 10,
  },
  image: {
    width: "100%",
    height: "100%",
  },
  section: {
    flexDirection: "row",
    // backgroundColor: "blue",
    justifyContent: "space-between",
    marginTop: "5%",
    height: "40%",
  },
  details: {
    alignItems: "flex-start",
    padding: 10,
  },
  date: {
    alignItems: "flex-end",
    padding: 30,
  },
  title: { fontSize: 18, marginVertical: 4, fontFamily: "open-sans-bold" },
  price: {
    fontSize: 14,
    color: "#888",
    fontFamily: "open-sans",
  },

  imageContainer: {
    width: "100%",
    height: "50%",
    borderTopLeftRadius: 10,
    borderTopRightRadius: 10,
    overflow: "hidden",
  },
  touchable: {
    borderRadius: 10,
    overflow: "hidden",
  },
});

export default ProductItem;
