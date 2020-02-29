// ignore: non_constant_identifier_names
double WGS84fromAPI(final String value) => double.parse(value) / 1000000;

// ignore: non_constant_identifier_names
double WGS84fromString(final String value) => double.parse(value);

// ignore: non_constant_identifier_names
double WGS84toAPI(final double value) => value * 1000000;
