import 'dart:core';
class GetHelpUsers {
  final String? Id;
  final int? Amount;
  final int? receiveAmount;

  GetHelpUsers(
      {
        this.Id,
        this.Amount,
        this.receiveAmount,
      });

  Map<String, dynamic> toJson() => {
    'Id':Id,
    'Amount': Amount,
    'receiveAmount': receiveAmount,
  };

  factory GetHelpUsers.fromJson(Map<String, dynamic> json) => GetHelpUsers(
      Amount: json['Amount'],
      receiveAmount: json['receiveAmount'],
      Id: json['Id']
  );
}
