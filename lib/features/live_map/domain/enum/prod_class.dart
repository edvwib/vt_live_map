enum ProdClass {
  /// Västtågen
  VAS,

  /// Long distance train
  LDT,

  /// Regional train
  REG,

  /// Bus
  BUS,

  /// Ferry
  BOAT,

  /// Tram
  TRAM,

  /// Taxi or Flexlinjen
  TAXI,

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
