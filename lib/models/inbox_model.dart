class InboxModel {
  InboxModel({
    required this.id,
    required this.creatorUserDetailId,
    required this.title,
    required this.letterDate,
    required this.letterContent,
    required this.fromId,
    required this.toId,
    required this.letterStatusCodeId,
    required this.rejectNote,
    required this.deletedAt,
    required this.letterDisposition,
    required this.letterCarbonCopy,
    required this.creator,
    required this.from,
    required this.to,
    required this.letterStatusCode,
  });
  late final int id;
  late final int creatorUserDetailId;
  late final String title;
  late final String letterDate;
  late final String letterContent;
  late final int fromId;
  late final int toId;
  late final int letterStatusCodeId;
  late final String rejectNote;
  late final String deletedAt;
  late final List<LetterDisposition> letterDisposition;
  late final List<LetterCarbonCopy> letterCarbonCopy;
  late final Creator creator;
  late final From from;
  late final To to;
  late final LetterStatusCode letterStatusCode;

  InboxModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    creatorUserDetailId = json['creator_user_detail_id'] ?? 0;
    title = json['title'] ?? '';
    letterDate = json['letter_date'] ?? '';
    letterContent = json['letter_content'] ?? '';
    fromId = json['from_id'] ?? 0;
    toId = json['to_id'];
    letterStatusCodeId = json['letter_status_code_id'] ?? 0;
    rejectNote = json['reject_note'] ?? '';
    deletedAt = json['delete_at'] ?? '';
    letterDisposition = json['letter_disposition'] == null
        ? []
        : List.from(json['letter_disposition'])
            .map((e) => LetterDisposition.fromJson(e))
            .toList();
    letterCarbonCopy = json['letter_carbon_copy'] == null
        ? []
        : List.from(json['letter_carbon_copy'])
            .map((e) => LetterCarbonCopy.fromJson(e))
            .toList();
    creator = Creator.fromJson(json['creator']);
    from = From.fromJson(json['from']);
    to = To.fromJson(json['to']);
    letterStatusCode = LetterStatusCode.fromJson(json['letter_status_code']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['creator_user_detail_id'] = creatorUserDetailId;
    _data['title'] = title;
    _data['letter_date'] = letterDate;
    _data['letter_content'] = letterContent;
    _data['from_id'] = fromId;
    _data['to_id'] = toId;
    _data['letter_status_code_id'] = letterStatusCodeId;
    _data['reject_note'] = rejectNote;
    _data['deleted_at'] = deletedAt;
    _data['letter_disposition'] =
        letterDisposition.map((e) => e.toJson()).toList();
    _data['letter_carbon_copy'] =
        letterCarbonCopy.map((e) => e.toJson()).toList();
    _data['creator'] = creator.toJson();
    _data['from'] = from.toJson();
    _data['to'] = to.toJson();
    _data['letter_status_code'] = letterStatusCode.toJson();
    return _data;
  }
}

class LetterDisposition {
  LetterDisposition({
    required this.id,
    required this.letterMasterId,
    required this.divisionId,
    required this.userDetailId,
    required this.sentAt,
    required this.message,
    required this.letterStatusCodeId,
  });
  late final int id;
  late final int letterMasterId;
  late final int divisionId;
  late final int userDetailId;
  late final String sentAt;
  late final String message;
  late final int letterStatusCodeId;

  LetterDisposition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    letterMasterId = json['letter_master_id'] ?? 0;
    divisionId = json['division_id'] ?? 0;
    userDetailId = json['user_detail_id'] ?? 0;
    sentAt = json['sent_at'] ?? '';
    message = json['message'] ?? '';
    letterStatusCodeId = json['letter_status_code_id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['letter_master_id'] = letterMasterId;
    _data['division_id'] = divisionId;
    _data['user_detail_id'] = userDetailId;
    _data['sent_at'] = sentAt;
    _data['message'] = message;
    _data['letter_status_code_id'] = letterStatusCodeId;
    return _data;
  }
}

class LetterCarbonCopy {
  LetterCarbonCopy({
    required this.id,
    required this.letterMasterId,
    required this.userDetailId,
    required this.userDetail,
  });
  late final int id;
  late final int letterMasterId;
  late final int userDetailId;
  late final UserDetail userDetail;

  LetterCarbonCopy.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    letterMasterId = json['letter_master_id'] ?? 0;
    userDetailId = json['user_detail_id'] ?? 0;
    userDetail = UserDetail.fromJson(json['user_detail']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['letter_master_id'] = letterMasterId;
    _data['user_detail_id'] = userDetailId;
    _data['user_detail'] = userDetail.toJson();
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
    id = json['id'] ?? 0;
    userId = json['user_id'] ?? 0;
    fullname = json['fullname'] ?? '';
    address = json['address'] ?? '';
    pob = json['pob'] ?? '';
    dob = json['dob'] ?? '';
    divisionId = json['division_id'] ?? 0;
    jobPositionId = json['job_position_id'] ?? 0;
    status = json['status'] ?? 0;
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

class Creator {
  Creator({
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

  Creator.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    userId = json['user_id'] ?? 0;
    fullname = json['fullname'] ?? '';
    address = json['address'] ?? '';
    pob = json['pob'] ?? '';
    dob = json['dob'] ?? '';
    divisionId = json['division_id'] ?? 0;
    jobPositionId = json['job_position_id'] ?? 0;
    status = json['status'] ?? 0;
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

class From {
  From({
    required this.id,
    required this.userId,
    required this.fullname,
    required this.address,
    required this.pob,
    required this.dob,
    required this.divisionId,
    required this.jobPositionId,
    required this.status,
    required this.type,
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
  late final String type;

  From.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'] ?? 0;
    fullname = json['fullname'] ?? '';
    address = json['address'] ?? '';
    pob = json['pob'] ?? '';
    dob = json['dob'] ?? '';
    divisionId = json['division_id'] ?? 0;
    jobPositionId = json['job_position_id'] ?? 0;
    status = json['status'] ?? 0;
    type = json['type'] ?? '';
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
    _data['type'] = type;
    return _data;
  }
}

class To {
  To({
    required this.id,
    required this.userId,
    required this.fullname,
    required this.address,
    required this.pob,
    required this.dob,
    required this.divisionId,
    required this.jobPositionId,
    required this.status,
    required this.type,
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
  late final String type;

  To.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'] ?? 0;
    fullname = json['fullname'] ?? '';
    address = json['address'] ?? '';
    pob = json['pob'] ?? '';
    dob = json['dob'] ?? '';
    divisionId = json['division_id'] ?? 0;
    jobPositionId = json['job_position_id'] ?? 0;
    status = json['status'] ?? 0;
    type = json['type'] ?? '';
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
    _data['type'] = type;
    return _data;
  }
}

class LetterStatusCode {
  LetterStatusCode({
    required this.id,
    required this.name,
    required this.description,
  });
  late final int id;
  late final String name;
  late final String description;

  LetterStatusCode.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    description = json['description'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    return _data;
  }
}
