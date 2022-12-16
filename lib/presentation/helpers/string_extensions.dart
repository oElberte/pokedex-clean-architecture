extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String removeGender() {
    if (contains('-m') || contains('-f')) {
      return substring(0, length - 2);
    }
    return this;
  }
}
