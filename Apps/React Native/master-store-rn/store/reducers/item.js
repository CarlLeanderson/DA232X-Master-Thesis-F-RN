import Item from "../../models/item.js";
import {
  CREATE_AD,
  GET_ADS,
  CHANGE_UPLOADING,
  FINISHED_UPLOADING,
} from "../actions/items.js";

const initialState = {
  allItems: [],
  userItems: [],
  uploadStatus: "",
  uploading: false,
};

export default (state = initialState, action) => {
  switch (action.type) {
    case CREATE_AD:
      const newAd = new Item(
        new Date().toString(),
        "u1",
        (title = action.adData.title),
        (imageURL = action.adData.image),
        (description = action.adData.description),
        (price = action.adData.price)
      );
      return {
        ...state,
        allItems: state.allItems.concat(newAd),
        userItems: state.userItems.concat(newAd),
      };
    case GET_ADS:
      return {
        ...state,
        allItems: action.ads,
        userItems: action.ads.filter((x) => x.ownerId === "u1"),
      };
    case CHANGE_UPLOADING:
      return {
        ...state,
        uploading: true,
        uploadingStatus: action.uploadingStatus,
      };
    case FINISHED_UPLOADING:
      return {
        ...state,
        uploading: false,
        uploadingStatus: "",
      };
  }
  return state;
};

//https://master-project-rn-f-default-rtdb.europe-west1.firebasedatabase.app
