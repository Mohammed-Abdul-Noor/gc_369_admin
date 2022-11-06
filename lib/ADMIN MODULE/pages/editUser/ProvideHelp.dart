import 'dart:core';
class ProvideHelpUsers {
  final String? Id;
  final int? Amount;
  final int? paidAmount;

  ProvideHelpUsers(
      {
        this.Id,
        this.Amount,
        this.paidAmount,
      });

  Map<String, dynamic> toJson() => {
    'Id':Id,
    'Amount': Amount,
    'paidAmount': paidAmount,

  };
  factory ProvideHelpUsers.fromJson(Map<String, dynamic> json) => ProvideHelpUsers(
      Amount: json['Amount'],
      paidAmount: json['paidAmount'],
      Id: json['Id']
  );
}
