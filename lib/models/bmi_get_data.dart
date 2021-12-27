class BmiData {
  String? bmi;
  String? date;
  String? user_uid;

  BmiData({this.bmi, this.date, this.user_uid});

  factory BmiData.fromJson(
      Map<String, dynamic> json) {
    return BmiData(
      bmi: json['bmi'],
      date: json['date'],
      user_uid: json['user_uid'],
    );
  }
}
