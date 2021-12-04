class UsersModel {
  UsersModel({
    required this.id,
    required this.userId,
    required this.fullname,
    required this.address,
    required this.pob,
    required this.dob,
    required this.divisionId,
    required this.jobPositionId,
    required this.status,
    required this.user,
    required this.division,
    required this.jobPosition,
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
  late final User user;
  late final Division division;
  late final JobPosition jobPosition;

  UsersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fullname = json['fullname'];
    address = json['address'];
    pob = json['pob'];
    dob = json['dob'];
    divisionId = json['division_id'];
    jobPositionId = json['job_position_id'];
    status = json['status'];
    user = User.fromJson(json['user']);
    division = Division.fromJson(json['division']);
    jobPosition = json['job_position'] == null
        ? JobPosition(id: 1, name: '')
        : JobPosition.fromJson(json['job_position']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.lastLogin,
    required this.lastActive,
    required this.status,
    required this.apiToken,
    required this.bearerToken,
    required this.roles,
  });
  late final int id;
  late final String username;
  late final String email;
  late final String lastLogin;
  late final String lastActive;
  late final int status;
  late final String apiToken;
  late final String bearerToken;
  late final List<Roles> roles;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'] ?? '';
    email = json['email'] ?? '';
    lastLogin = json['last_login'] ?? '';
    lastActive = json['last_active'] ?? '';
    status = json['status'];
    apiToken = json['api_token'] ?? '';
    bearerToken = json['bearer_token'] ?? '';
    roles = List.from(json['roles']).map((e) => Roles.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['email'] = email;
    _data['last_login'] = lastLogin;
    _data['last_active'] = lastActive;
    _data['status'] = status;
    _data['api_token'] = apiToken;
    _data['bearer_token'] = bearerToken;
    _data['roles'] = roles.map((e) => e.toJson()).toList();
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

class Division {
  Division({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  Division.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class JobPosition {
  JobPosition({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  JobPosition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}
