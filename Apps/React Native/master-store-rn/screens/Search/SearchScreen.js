import React, { useState } from "react";
import { View, StyleSheet, Text, TextInput, FlatList } from "react-native";
import { useSelector, useDispatch } from "react-redux";
import ProductItem from "../../components/Ad";

const SearchScreen = ({ navigation }) => {
  //Get data from store
  const allitems = useSelector((state) => state.items.allItems);
  const [items, setItems] = useState([]);

  const filter = (text) => {
    text = text.toLowerCase();
    const filteredResults = allitems.filter((item) => {
      if (text !== "") {
        return item.title.toLowerCase().includes(text);
      }
    });
    setItems(filteredResults);
  };

  const dispatch = useDispatch();

  //Flatlist needs array + renterItem
  //Why flatlist? - Better for performance (Only loads what's visible on the screen)
  return (
    <View style={styles.main}>
      <TextInput
        style={styles.searchBar}
        onChangeText={(text) => {
          setTimeout(() => {
            filter(text);
          }, 1000);
        }}
        clearButtonMode="always"
      />
      {items && (
        <FlatList
          data={items}
          renderItem={(itemData) => (
            <ProductItem
              image={itemData.item.imageUrl}
              title={itemData.item.title}
              price={itemData.item.price}
              onViewDetail={() => {
                navigation.navigate("ViewAdScreen", {
                  itemId: itemData.item.id,
                  title: itemData.item.title,
                });
              }}
              onAddToCart={() => {
                dispatch(cartActions.addToCart(itemData.item));
              }}
            />
          )}
        />
      )}
    </View>
  );
};

export default SearchScreen;

const styles = StyleSheet.create({
  main: {
    backgroundColor: "white",
    height: "100%",
  },
  titleText: {
    fontSize: 20,
    textAlign: "left",
    marginVertical: 20,
    fontFamily: "open-sans-bold",
  },
  container: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
  },
  searchBar: {
    fontSize: 24,
    margin: "5%",
    width: "90%",
    height: 50,
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
  },
});
