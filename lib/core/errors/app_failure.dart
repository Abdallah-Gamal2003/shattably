/// Stable application failure; SDK exceptions never cross a repository boundary.
class AppFailure implements Exception {
  const AppFailure(this.code, this.message);
  final String code;
  final String message;
  @override
  String toString() => message;
}
