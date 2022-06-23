import { LOGIN, SIGNUP, LOGOUT, SIGNUP_STATUS } from "../actions/login";
const initialState = {
  token: null,
  userId: null,
  email: null,
  signupStatus: false,
};

export default (state = initialState, action) => {
  switch (action.type) {
    case LOGIN:
      return {
        token: action.token,
        userId: action.id,
        email: action.email,
      };
    case SIGNUP:
      return {
        token: action.token,
        userId: action.id,
      };
    case SIGNUP_STATUS:
      return {
        ...state,
        signupStatus: action.status,
      };
    case LOGOUT:
      return initialState;
    default:
      return state;
  }
};
