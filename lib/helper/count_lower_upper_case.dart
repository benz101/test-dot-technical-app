class CountLowerUpperCase {
  bool check(String text) {
    RegExp regEx = RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+");
    return regEx.hasMatch(text);
  }
}
