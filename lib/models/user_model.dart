class UserModel {
  UserModel({
    required this.userDetail,
    required this.roles,
    required this.apiToken,
  });

  /// Empty user which represents an unauthenticated user.
  static final empty = UserModel(
      apiToken: '',
      userDetail: UserDetail(
          id: 0,
          userId: 0,
          fullname: '',
          address: '',
          pob: '',
          dob: '',
          divisionId: 0,
          jobPositionId: 0,
          status: 0),
      roles: []);

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == UserModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != UserModel.empty;

  late final UserDetail userDetail;
  late final List<Roles> roles;
  late final String apiToken;

  UserModel.fromJson(Map<String, dynamic> json) {
    userDetail = UserDetail.fromJson(json['user_detail']);
    roles = List.from(json['roles']).map((e) => Roles.fromJson(e)).toList();
    apiToken = json['api_token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_detail'] = userDetail.toJson();
    _data['roles'] = roles.map((e) => e.toJson()).toList();
    _data['api_token'] = apiToken;
    return _data;
  }
}

class UserDetail {
  UserDetail({
    required this.id,
    required this.userId,
    required this.fullname,
    required this.address,
    required this.pob,
    required this.dob,
    required this.divisionId,
    required this.jobPositionId,
    required this.status,
  });
  late final int id;
  late final int userId;
  late final String fullname;
  late final String address;
  late final String pob;
  late final String dob;
  late final int divisionId;
  late final int jobPositionId;
  late final int status;

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fullname = json['fullname'];
    address = json['address'];
    pob = json['pob'];
    dob = json['dob'];
    divisionId = json['division_id'];
    jobPositionId = json['job_position_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['fullname'] = fullname;
    _data['address'] = address;
    _data['pob'] = pob;
    _data['dob'] = dob;
    _data['division_id'] = divisionId;
    _data['job_position_id'] = jobPositionId;
    _data['status'] = status;
    return _data;
  }
}

class Roles {
  Roles({
    required this.id,
    required this.name,
    required this.isAdmin,
  });
  late final int id;
  late final String name;
  late final int isAdmin;

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isAdmin = json['is_admin'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['is_admin'] = isAdmin;
    return _data;
  }
}
