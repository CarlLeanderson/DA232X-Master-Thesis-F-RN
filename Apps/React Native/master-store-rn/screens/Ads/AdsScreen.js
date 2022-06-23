import React, { useEffect } from "react";
import {
  RefreshControl,
  ActivityIndicator,
  View,
  FlatList,
  StyleSheet,
} from "react-native";
import { useSelector, useDispatch } from "react-redux";
import ProductItem from "../../components/Ad";
import * as itemActions from "../../store/actions/items";
import { wait } from "../../constants/Wait";

const AdsScreen = ({ navigation }) => {
  //Get data from store
  const dispatch = useDispatch();
  const items = useSelector((state) => state.items.allItems);
  const [refreshing, setRefreshing] = React.useState(false);

  useEffect(() => {
    dispatch(itemActions.getAds());
  }, []);

  const onRefresh = React.useCallback(() => {
    setRefreshing(true);
    dispatch(itemActions.getAds()).then(() => {
      wait(2000).then(() => setRefreshing(false));
    });
  }, []);

  //Flatlist needs array + renterItem
  //Why flatlist? - Better for performance (Only loads what's visible on the screen)
  return (
    <View style={styles.main}>
      {items.length === 0 ? (
        <ActivityIndicator style={styles.spinner} />
      ) : (
        <FlatList
          refreshControl={
            <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
          }
          data={items}
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
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  spinner: {
    margin: 50,
    color: "#999999",
  },
  scrollView: {},
  main: {
    backgroundColor: "white",
    height: "100%",
  },
});
export default AdsScreen;
