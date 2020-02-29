import 'package:flutter_translate/flutter_translate.dart';
import 'package:vt_live_map/core/lang/lang.dart';

enum ProdClass {
  /// Bus
  BUS,

  /// Tram
  TRAM,

  /// Ferry
  BOAT,

  /// Taxi or Flexlinjen
  TAXI,

  /// Västtågen
  VAS,

  /// Long distance train
  LDT,

  /// Regional train
  REG,

  /// Unknown
  UNKNOWN,
}

String getProdClassValue(final ProdClass prodClass) {
  return prodClass.toString().split('.').last.toUpperCase();
}

ProdClass getProdClass(final String prodClass) {
  switch (prodClass) {
    case 'VAS':
      return ProdClass.VAS;
    case 'LDT':
      return ProdClass.LDT;
    case 'REG':
      return ProdClass.REG;
    case 'BUS':
      return ProdClass.BUS;
    case 'BOAT':
      return ProdClass.BOAT;
    case 'TRAM':
      return ProdClass.TRAM;
    case 'TAXI':
      return ProdClass.TAXI;
    default:
      return ProdClass.UNKNOWN;
  }
}

String translateProdClass(final ProdClass pc) {
  final String pcValue = getProdClassValue(pc);
  String pcString = 'unknown';

  switch (pcValue) {
    case 'VAS':
      pcString = 'train_type.vasttagen';
      break;
    case 'LDT':
      pcString = 'train_type.long_distance';
      break;
    case 'REG':
      pcString = 'train_type.regional';
      break;
    default:
      pcString = pcValue.toLowerCase();
  }

  return translate(
    Lang.VEHICLE_TYPE_BUS.replaceFirst('bus', pcString),
  );
}
