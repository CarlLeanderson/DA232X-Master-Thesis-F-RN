import React from "react";
import { FlatList, StyleSheet, View } from "react-native";
import { useSelector } from "react-redux";
import ProductItem from "../../components/Ad";

const MyAdsScreen = ({ navigation }) => {
  //Get data from store
  // const items = useSelector((state) => state.items.allItems);
  //const dispatch = useDispatch();
  //Flatlist needs array + renterItem
  //Why flatlist? - Better for performance (Only loads what's visible on the screen)
  const items = useSelector((state) => state.items.allItems);
  const userId = useSelector((state) => state.user.userId);
  const userItems = items.filter((x) => x.ownerId === userId);

  return (
    <View style={styles.main}>
      <FlatList
        data={userItems}
        renderItem={(itemData) => (
          <ProductItem
            image={itemData.item.imageUrl}
            title={itemData.item.title}
            price={itemData.item.price}
            date={itemData.item.date}
            onViewDetail={() => {
              navigation.navigate("ViewAdScreen", {
                itemId: itemData.item.id,
                title: itemData.item.title,
              });
            }}
          />
        )}
      />
    </View>
  );
};
const styles = StyleSheet.create({
  main: {
    backgroundColor: "white",
    height: "100%",
  },
});
export default MyAdsScreen;
