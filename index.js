import { NativeModules, BackHandler, Platform } from 'react-native';

const exitApp = (rootTag = 1) => {
  if (Platform.OS === 'ios') {
    NativeModules.RNExit.exitApp(rootTag);
    return;
  }
  BackHandler.exitApp();
};

export default {
  exitApp,
};
