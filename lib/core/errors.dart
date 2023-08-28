class ErrorList {
  String errorCode;
  String errorMsg;

  ErrorList({
    required this.errorCode,
    required this.errorMsg,
  });

  factory ErrorList.fromJson(Map<dynamic, dynamic> json) {
    return ErrorList(
      errorCode: json["ErrorCode"],
      errorMsg: json["ErrorMSG"].toString(),
    );
  }
}