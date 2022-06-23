import { StyleSheet, Text, TouchableOpacity } from "react-native";
const CustomButton = (props) => {
  if (props.color != undefined) {
  }
  return (
    <TouchableOpacity
      style={
        props.color
          ? [styles.button, { backgroundColor: props.color }]
          : styles.button
      }
      onPress={() => props.onPress()}
    >
      <Text style={styles.buttonStyle}>{props.title}</Text>
    </TouchableOpacity>
  );
};
const styles = StyleSheet.create({
  button: {
    alignItems: "center",
    backgroundColor: "#00668f",
    width: "90%",
    margin: "5%",
    padding: 10,
    borderRadius: 10,
  },
  buttonStyle: {
    color: "white",
  },
});

export default CustomButton;
