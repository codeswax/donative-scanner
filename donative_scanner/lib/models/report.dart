class Report {
  final String idUser;
  final String reportDate;
  final List<int> donatives;

  Report({
    required this.idUser,
    required this.reportDate,
    required this.donatives,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
        idUser: json['idUser'].toString(),
        reportDate: json['reportDate'].toString(),
        donatives: json['donatives'] as List<int>);
  }
}
