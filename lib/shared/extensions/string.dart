extension StringExtension on String {
  String shortenText({int maxLength = 15}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}…';
  }
}
