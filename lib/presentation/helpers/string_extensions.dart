extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String removeGender() {
    if (contains('-m') || contains('-f')) {
      return substring(0, length - 2);
    }
    return this;
  }

  String fixId() {
    if (length == 1) {
      return '#00$this';
    } else if (length == 2) {
      return '#0$this';
    } else {
      return '#$this';
    }
  }
}
