extension MapExtention on Map {
  Map<String, String> convertDynamicToString() {
    final convertedMap = <String, String>{};
    forEach((key, value) {
      if (value != null) {
        convertedMap[key] = value.toString();
      }
    });
    return convertedMap;
  }
}
