export const SIGNUP = "SIGNUP";
export const LOGIN = "LOGIN";
export const LOGOUT = "LOGOUT";
export const SIGNUP_STATUS = "SIGNUP_STATUS";

export const signup = (email, password) => {
  return async (dispatch) => {
    const response = await fetch("Insert here", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        email: email,
        password: password,
        returnSecureToken: true,
      }),
    });

    if (!response.ok) {
      alert("Couldn't sign up");
    }

    const resData = await response.json();
    dispatch({ type: SIGNUP, token: resData.idToken, id: resData.localId });
  };
};

export const login = (email, password) => {
  return async (dispatch) => {
    const response = await fetch("Insert here", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        email: email,
        password: password,
        returnSecureToken: true,
      }),
    });

    if (!response.ok) {
      alert("Could not sign in!");
    }

    const resData = await response.json();
    dispatch({
      type: LOGIN,
      token: resData.idToken,
      id: resData.localId,
      email: email,
    });
  };
};

export const logout = () => {
  return { type: LOGOUT };
};

export const signupStatus = (status) => {
  return { type: SIGNUP_STATUS, status: status };
};
