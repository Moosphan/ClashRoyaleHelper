/// Response on Error state.
class ErrorResponse {
  String reason;
  String message;
  String type;
  Detail detail;

  ErrorResponse({this.reason, this.message, this.type, this.detail});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    message = json['message'];
    type = json['type'];
    detail = json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reason'] = this.reason;
    data['message'] = this.message;
    data['type'] = this.type;
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    return data;
  }
}

class Detail {

  Detail.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}