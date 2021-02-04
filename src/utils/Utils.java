package utils;

import utils.Type.Type;

public class Utils {

  public static void check(Type type, Class target) {
    if (type.getClass() != target) {
      throw new IllegalArgumentException("Semantic check: type failed to match");
    }
  }
}
