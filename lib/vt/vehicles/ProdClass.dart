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

enum VehicleIcon {
  BUS,

  TRAM,

  FERRY,

  TRAIN,

  TAXI,

  UNKNOWN,
}

String getProdClassValue(ProdClass prodClass) {
  return prodClass.toString().split('.').last.toLowerCase();
}

String getVehicleIconValue(VehicleIcon vehicleIcon) {
  return vehicleIcon.toString().split('.').last.toLowerCase();
}

VehicleIcon getVehicleIcon(ProdClass prodClass) {
  switch (prodClass) {
    case ProdClass.VAS:
      return VehicleIcon.TRAIN;
    case ProdClass.LDT:
      return VehicleIcon.TRAIN;
    case ProdClass.REG:
      return VehicleIcon.TRAIN;
    case ProdClass.BUS:
      return VehicleIcon.BUS;
    case ProdClass.BOAT:
      return VehicleIcon.FERRY;
    case ProdClass.TRAM:
      return VehicleIcon.TRAM;
    case ProdClass.TAXI:
      return VehicleIcon.TAXI;
    default:
      return VehicleIcon.UNKNOWN;
  }
}

ProdClass getProdClass(String prodClass) {
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

ProdClass getEncodedProdClass(String prodClass) {
  switch (prodClass) {
    case 'Västtågen':
      return ProdClass.VAS;
    case 'Långdistanståg':
      return ProdClass.LDT;
    case 'Regionaltåg':
      return ProdClass.REG;
    case 'Buss':
      return ProdClass.BUS;
    case 'Färja':
      return ProdClass.BOAT;
    case 'Spårvagn':
      return ProdClass.TRAM;
    case 'Taxi / Flexlinjen':
      return ProdClass.TAXI;
    default:
      return ProdClass.UNKNOWN;
  }
}

String getDecodedProdClass(ProdClass prodClass) {
  switch (prodClass) {
    case ProdClass.VAS:
      return 'Västtågen';
    case ProdClass.LDT:
      return 'Långdistanståg';
    case ProdClass.REG:
      return 'Regionaltåg';
    case ProdClass.BUS:
      return 'Buss';
    case ProdClass.BOAT:
      return 'Färja';
    case ProdClass.TRAM:
      return 'Spårvagn';
    case ProdClass.TAXI:
      return 'Taxi / Flexlinjen';
    default:
      return prodClass.toString();
  }
}
