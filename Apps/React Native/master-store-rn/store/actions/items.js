export const CREATE_AD = "CREATE_AD";
export const GET_ADS = "GET_ADS";
export const CHANGE_UPLOADING = "CHANGE_UPLOADING";
export const FINISHED_UPLOADING = "FINISHED_UPLOADING";
import Item from "../../models/item";
import {
  getStorage,
  ref,
  uploadBytesResumable,
  getDownloadURL,
} from "firebase/storage";
import { app } from "../../firebase/firebaseConfig";

export const createAd = (title, description, price, image) => {
  return {
    type: CREATE_AD,
    adData: {
      title,
      description,
      price,
      image,
    },
  };
};

export const getAds = () => {
  return async (dispatch) => {
    const response = await fetch("Insert here/ads.json", {
      method: "GET",
    });
    const resData = await response.json();
    const ADS = [];
    for (var key in resData) {
      ADS.push(
        new Item(
          key,
          resData[key].ownerId,
          resData[key].title,
          resData[key].imageURL,
          resData[key].description,
          resData[key].price,
          resData[key].date,
          resData[key].email
        )
      );
    }
    dispatch({ type: GET_ADS, ads: ADS });
  };
};

export const uploadImage = (title, description, price, uri, ownerId, email) => {
  return async (dispatch) => {
    const storage = getStorage(app);

    //Convert URI to Blob
    try {
      const blob = await new Promise((resolve, reject) => {
        const xhr = new XMLHttpRequest();
        xhr.onload = function () {
          resolve(xhr.response);
        };
        xhr.onerror = function (e) {
          console.log(e);
          reject(new TypeError("Network request failed"));
        };
        xhr.responseType = "blob";
        xhr.open("GET", uri, true);
        xhr.send(null);
      });
      const storageRef = ref(
        storage,
        "/images/" + new Date().toISOString() + ".jpg"
      );
      const uploadTask = uploadBytesResumable(storageRef, blob);

      uploadTask.on(
        "state_changed",
        (snapshot) => {
          let progress =
            (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          dispatch({
            type: CHANGE_UPLOADING,
            uploadingStatus: Math.round(progress),
          });
          switch (snapshot.state) {
            case "paused":
              break;
            case "running":
              break;
          }
        },
        (error) => {
          switch (error.code) {
            case "storage/unauthorized":
              alert("Access denied");
              break;
            case "storage/canceled":
              alert("Upload cancelled");
              break;
            case "storage/unknown":
              alert("Unknown error occurred");
              break;
          }
        },
        () => {
          getDownloadURL(uploadTask.snapshot.ref).then((downloadURL) => {
            uploadData(title, description, price, downloadURL, ownerId, email);
            dispatch({ type: FINISHED_UPLOADING });
            alert("Upload finished successfully");
          });
        }
      );
    } catch (err) {
      {
        alert("No image found");
        console.log(err);
      }
    }
  };
};

async function uploadData(title, description, price, imageURL, ownerId, email) {
  const date = new Date().toString();
  const response = await fetch("Insert here/ads.json", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      ownerId,
      title,
      imageURL,
      description,
      price,
      date,
      email,
    }),
  });
  const resData = await response.json();

  return;
}
