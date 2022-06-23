import React, { useState, useEffect } from "react";
import {
  Button,
  Image,
  View,
  StyleSheet,
  Text,
  TextInput,
  ActivityIndicator,
  Modal,
} from "react-native";
import * as ImagePicker from "expo-image-picker";
//import uploadImage from "../../firebase/firebaseConfig";
//import uploadImage from "../../firebase/firebaseConfig";
import * as adActions from "../../store/actions/items";
import { useSelector, useDispatch } from "react-redux";
import CustomButton from "../../components/CustomButton";

export default function ({ navigation }) {
  const [image, setImage] = useState(null);
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [price, setPrice] = useState("");
  const ownerId = useSelector((state) => state.user.userId);
  const uploading = useSelector((state) => state.items.uploading);
  const uploadingStatus = useSelector((state) => state.items.uploadingStatus);
  const email = useSelector((state) => state.user.email);
  const [status, requestPermission] = ImagePicker.useCameraPermissions();
  const dispatch = useDispatch();

  async function upload(title, description, price, email) {
    dispatch(
      adActions.uploadImage(title, description, +price, image, ownerId, email)
    );
  }

  useEffect(() => {
    if (!uploading) {
      clear();
    }
  }, [uploading]);

  const clear = () => {
    setTitle("");
    setImage("");
    setDescription("");
    setPrice("");
    setImage(null);
  };

  const onPressHandler = () => {
    if (image) {
      upload(title, description, price, email);
      return;
    }
    alert("Please select an image");
  };

  const pickImage = async () => {
    try {
      const permissionResult =
        await ImagePicker.requestCameraPermissionsAsync();
      //Open Camera
      const result = await ImagePicker.launchCameraAsync({
        allowsEditing: true,
        aspect: [4, 3],
        quality: 0,
      });
      if (!result.cancelled) {
        setImage(result.uri);
      }
      if (permissionResult.granted === false) {
        alert("You've refused to allow this appp to access your camera!");
        return;
      }
    } catch {
      //Open Image library
      //No permissions request is necessary for launching the image library
      //For simulator
      const result = await ImagePicker.launchImageLibraryAsync({
        mediaTypes: ImagePicker.MediaTypeOptions.All,
        allowsEditing: true,
        aspect: [4, 3],
        quality: 1,
      });
      if (!result.cancelled) {
        setImage(result.uri);
      }
    }
  };

  return (
    <View style={styles.main}>
      {uploading && (
        <Modal
          animationType="slide"
          transparent={true}
          visible={uploading}
          onRequestClose={() => {
            Alert.alert("Modal has been closed.");
            setModalVisible(!modalVisible);
          }}
        >
          <View style={styles.centeredView}>
            <View style={styles.modalView}>
              <Text style={styles.titleText}>Uploading</Text>
              <ActivityIndicator />
              <Text style={styles.titleText}>{uploadingStatus}</Text>
            </View>
          </View>
        </Modal>
      )}
      <Text style={styles.titleText}>Create New Ad</Text>
      <Text style={styles.inputTitleText}>Title</Text>
      <TextInput
        onChangeText={(input) => setTitle(input)}
        value={title}
        style={styles.searchBar}
        clearButtonMode="always"
      ></TextInput>
      <Text style={styles.inputTitleText}>Description</Text>
      <TextInput
        value={description}
        onChangeText={(input) => setDescription(input)}
        style={styles.searchBar}
        clearButtonMode="always"
      ></TextInput>
      <Text style={styles.inputTitleText}>Price</Text>
      <TextInput
        keyboardType="numeric"
        value={price}
        onChangeText={(input) => setPrice(input)}
        style={styles.searchBar}
        clearButtonMode="always"
      ></TextInput>

      <View style={styles.container}>
        {image ? (
          <Image source={{ uri: image }} style={{ width: 100, height: 100 }} />
        ) : (
          <Image
            source={require("../../assets/default.jpeg")}
            style={{ width: 100, height: 100 }}
          />
        )}
        <Button title="Select image" onPress={pickImage} />
        <CustomButton title={"Save"} onPress={onPressHandler} />
        <Button
          title="Clear"
          onPress={() => {
            clear();
          }}
        />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  main: {
    backgroundColor: "white",
    height: "100%",
  },
  titleText: {
    fontSize: 20,
    textAlign: "center",
    marginVertical: 20,

    fontFamily: "open-sans-bold",
  },
  inputTitleText: {
    fontSize: 14,
    marginLeft: 20,
    textAlign: "left",
    alignItems: "flex-start",
    fontFamily: "open-sans-bold",
  },
  container: {
    alignItems: "center",
    justifyContent: "center",
    backgroundColor: "white",
  },
  searchBar: {
    fontSize: 14,
    margin: "5%",
    width: "90%",
    height: 30,
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
  modalView: {
    marginTop: "70%",
    backgroundColor: "white",
    borderRadius: 20,
    padding: 35,
    width: "80%",
    margin: "10%",
    alignItems: "center",
    shadowColor: "#000",
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.25,
    shadowRadius: 4,
    elevation: 5,
  },
});

/*
  <View>
      {uploading ? (
        <View>
          <Text style={styles.titleText}>Uploading</Text>
          <ActivityIndicator />
          <Text style={styles.titleText}>{uploadingStatus}</Text>
        </View>
      ) : (
        <View>
          <Text style={styles.titleText}>Create New Ad</Text>
          <Button
            title="Clear"
            onPress={() => {
              clear();
            }}
          />
          <Text style={styles.inputTitleText}>Title</Text>
          <TextInput
            onChangeText={(input) => setTitle(input)}
            value={title}
            style={styles.searchBar}
            clearButtonMode="always"
          ></TextInput>
          <Text style={styles.inputTitleText}>Description</Text>
          <TextInput
            value={description}
            onChangeText={(input) => setDescription(input)}
            style={styles.searchBar}
            clearButtonMode="always"
          ></TextInput>
          <Text style={styles.inputTitleText}>Price</Text>
          <TextInput
            keyboardType="numeric"
            value={price}
            onChangeText={(input) => setPrice(input)}
            style={styles.searchBar}
            clearButtonMode="always"
          ></TextInput>

          <View style={styles.container}>
            {image ? (
              <Image
                source={{ uri: image }}
                style={{ width: 200, height: 200 }}
              />
            ) : (
              <Image
                source={require("../../assets/default.jpeg")}
                style={{ width: 200, height: 200 }}
              />
            )}
            <Button
              title="Pick an image from camera roll"
              onPress={pickImage}
            />

            <Button title="Save" onPress={onPressHandler} />
          </View>
        </View>
      )}
    </View>

*/
