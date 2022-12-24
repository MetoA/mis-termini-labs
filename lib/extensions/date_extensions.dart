import 'package:jiffy/jiffy.dart';

extension DateStrings on DateTime {
  String dateString() {
    return Jiffy(this).format('dd/MM/yyyy HH:mm');
  }
}
