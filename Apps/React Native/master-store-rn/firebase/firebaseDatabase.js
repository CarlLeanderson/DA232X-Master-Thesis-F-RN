import { getDatabase, ref, set } from "firebase/database";

async function removeAd(id) {
  const db = getDatabase();
  try {
    set(ref(db, "ads/" + id), {
      null: null,
    }).then(() => {
      return true;
    });
  } catch (err) {
    console.log(err);
    return false;
  }
}

export { removeAd };
