import 'dart:core';
class GenIdModel {
  final String? firstGenId;
  final String? secondGenId;
  final String? thirdGenId;

  GenIdModel(
      {
        this.firstGenId,
        this.secondGenId,
        this.thirdGenId,
      });

  Map<String, dynamic> toJson() => {
    'firstGenId':firstGenId,
    'secondGenId': secondGenId,
    'thirdGenId': thirdGenId,

  };

  factory GenIdModel.fromJson(Map<String, dynamic> json) => GenIdModel(
      secondGenId: json['secondGenId'],
      thirdGenId: json['thirdGenId'],
      firstGenId: json['firstGenId']
  );
}
