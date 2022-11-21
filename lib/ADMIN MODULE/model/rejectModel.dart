class RejectModel {
  String? senderId;
  DateTime? sendTime;
  String? file;
  String? paymentM;
  int? senderlevel;
  String? receiverId;
  String? amount;

  RejectModel({
    this.senderId,
    this.file,
    this.paymentM,
    this.amount,
    this.receiverId,
    this.senderlevel,
    this.sendTime,
  });

  RejectModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'] ?? "";
    receiverId = json['receiverId'] ?? "";
    sendTime = json['sendTime'] == null ? DateTime.now() : json['sendTime'].toDate();
    file = json['file'] ?? "";
    paymentM = json['paymentM'] ?? "";
    amount = json['amount'] ?? {};
    senderlevel = json['senderlevel'] ?? {};
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['senderId'] = senderId;

    data['senderlevel'] = senderlevel;

    data['receiverId'] = receiverId;

    data['sendTime'] = sendTime ?? DateTime.now();

    data['file'] = file ?? "";

    data['paymentM'] = paymentM ?? "";

    data['amount'] = amount ?? {};

    return data;
  }
}