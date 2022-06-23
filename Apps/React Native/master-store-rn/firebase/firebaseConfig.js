import { initializeApp } from "firebase/app";

import {
  getStorage,
  ref,
  uploadBytesResumable,
  getDownloadURL,
} from "firebase/storage";

const firebaseConfig = {
  apiKey: "Insert here",
  authDomain: "Insert here",
  databaseURL: "Insert here",
  projectId: "Insert here",
  storageBucket: "Insert here",
  messagingSenderId: "Insert here",
  appId: "Insert here",
};

export const app = initializeApp(firebaseConfig);

export default async function uploadImage(
  title,
  description,
  price,
  uri,
  ownerId
) {
  const storage = getStorage();

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
        let progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;

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
            break;
          case "storage/canceled":
            break;
          case "storage/unknown":
            break;
        }
      },
      () => {
        getDownloadURL(uploadTask.snapshot.ref).then((downloadURL) => {
          uploadData(title, description, price, downloadURL, ownerId);
        });
      }
    );
  } catch (err) {
    {
      alert("No image found");
      console.log(err);
    }
  }
}

async function uploadData(title, description, price, imageURL, ownerId) {
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
    }),
  });
  const resData = await response.json();

  return true;
}
