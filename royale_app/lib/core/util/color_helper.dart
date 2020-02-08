// Copyright 2019 Ucardstore LLC. All rights reserved.

/// A helper to handle colors.
/// by Moosphon
class ColorHelper {

  /// get color by hex format. e.g. #FFFFFF (white)
  static int fromHexString(String argbHexString) {
    String useString = argbHexString;
    if (useString.startsWith("#")) {
      useString = useString.substring(1); // trim the starting '#'
    }
    if (useString.length < 8) {
      useString = "FF" + useString;
    }
    if (!useString.startsWith("0x")) {
      useString = "0x" + useString;
    }
    return int.parse(useString);
  }
}