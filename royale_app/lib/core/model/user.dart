// Copyright 2019 Ucardstore LLC. All rights reserved.

/// User data after login.
class User {
  int age;
  String account;
  String avatar;
  String birthday;
  String code;
  String createTime;
  int day;
  String email;
  int gender;
  int id;
  List<String> interests;
  String member;
  int month;
  String nickname;
  String phone;
  String token;
  // 用户状态 0: 未激活 | 1: 已激活 | 2: 已失效 | 3: 已删除
  int userStatus;
  String username;
  int year;
  String country;
  String province;
  String city;
  String userSign;
  String constellation;
  int letterPublic; // 世界信件的权限状态: 1->公开，2->隐私
  int sendCount;

  User(
      {this.age,
        this.avatar,
        this.birthday,
        this.code,
        this.createTime,
        this.day,
        this.email,
        this.gender,
        this.id,
        this.interests,
        this.member,
        this.month,
        this.nickname,
        this.phone,
        this.token,
        this.userStatus,
        this.username,
        this.year,
        this.country,
        this.province,
        this.city,
        this.userSign,
        this.constellation,
        this.account,
        this.letterPublic,
        this.sendCount
      });

  User.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    avatar = json['avatar'];
    birthday = json['birthday'];
    code = json['code'];
    createTime = json['createTime'];
    day = json['day'];
    email = json['email'];
    gender = json['gender'];
    id = json['id'];
    interests = json['interests'] == null ? null : json['interests'].cast<String>();
    member = json['member'];
    month = json['month'];
    nickname = json['nickname'];
    phone = json['phone'];
    token = json['token'];
    userStatus = json['userStatus'];
    username = json['username'];
    year = json['year'];
    country = json['country'];
    province = json['province'];
    city = json['city'];
    account = json['account'];
    userSign = json['userSign'];
    constellation = json['constellation'];
    letterPublic = json['letterPublic'];
    sendCount = json['sendCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['avatar'] = this.avatar;
    data['birthday'] = this.birthday;
    data['code'] = this.code;
    data['createTime'] = this.createTime;
    data['day'] = this.day;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['interests'] = this.interests;
    data['member'] = this.member;
    data['month'] = this.month;
    data['nickname'] = this.nickname;
    data['phone'] = this.phone;
    data['token'] = this.token;
    data['userStatus'] = this.userStatus;
    data['username'] = this.username;
    data['year'] = this.year;
    data['country'] = this.country;
    data['province'] = this.province;
    data['city'] = this.city;
    data['account'] = this.account;
    data['userSign'] = this.userSign;
    data['constellation'] = this.constellation;
    data['letterPublic'] = this.letterPublic;
    data['sendCount'] = this.sendCount;
    return data;
  }
}
