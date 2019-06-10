import { NativeModules } from 'react-native';

const exitApp = (data = {}) => {
  NativeModules.RNExit.exitApp(data);
};

export default {
  exitApp
};
