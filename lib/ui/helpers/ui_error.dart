enum UIError {
  badRequest,
  unexpected,
  invalidData,
}

extension UIErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.badRequest:
        return 'Something wrong happened. Try again later.';
      case UIError.invalidData:
        return 'Something wrong happened. Try refresh the app.';
      default:
        return 'Something wrong happened. Try again later or refresh the app.';
    }
  }
}
