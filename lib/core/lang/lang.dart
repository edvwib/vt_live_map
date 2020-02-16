import 'package:flutter_translate_annotations/flutter_translate_annotations.dart';

part 'lang.g.dart';

@TranslateKeysOptions(
    path: 'assets/i18n', caseStyle: CaseStyle.upperCase, separator: "_")
class _$Lang {}
