class VerifyModel {
  final String tckn, dateYear;
  VerifyModel({required this.tckn, required this.dateYear});

  Map<String, dynamic> toJson() => {'tckn': tckn, 'dateYear': dateYear};
}
