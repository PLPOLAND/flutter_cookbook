import 'diacritics.dart';

int compareStrings(String a, String b) {
  a = a.withoutDiacritics;
  b = b.withoutDiacritics;
  if (a == b) {
    return 0;
  }
  // else if (a.length < b.length) {
  //   return -1;
  // } else if (a.length > b.length) {
  //   return 1;
  // }
  else {
    for (int i = 0; i < a.length; i++) {
      if (a[i] == b[i]) {
        continue;
      } else if (a[i].codeUnitAt(0) < b[i].codeUnitAt(0)) {
        return -1;
      } else if (a[i].codeUnitAt(0) > b[i].codeUnitAt(0)) {
        return 1;
      }
    }
  }
  return 0;
}
