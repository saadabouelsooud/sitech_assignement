class WrapperModel {
  int? status;
  String? message;
  var data;

  WrapperModel({this.data, this.status, this.message});

  factory WrapperModel.fromJson(Map<String, dynamic> json) {
    return WrapperModel(message: json['message'] as String, status: json['status'] as int, data: json['data']);
  }
}

abstract class Result<T> {}

class Success<T> implements Result {
  T data;

  Success(this.data);
}

class Error implements Result {
  String? message;
  Exception? e;

  Error({this.message, this.e});
}
