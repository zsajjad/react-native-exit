import { NativeModules } from 'react-native';

const exitApp = (data = {}, method = 'DISMISS') => {
  NativeModules.RNExit.exitApp(data, method);
};

export default {
  exitApp
};
