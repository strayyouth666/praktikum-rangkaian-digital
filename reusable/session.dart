import 'dart:convert';

import 'model.dart';


class Session extends Model {
  late String sessionName,
      id,
      programId,
      conferenceLink,
      description,
      coachId,
      timezone,
      coachName;
  late DateTime sessionStartTime, sessionEndTime;
  late Duration duration;

  @override
  void fromJson(Map<String, dynamic> data) {
    if (data.containsKey('data')) data = data['data'];

    final timezoneRemover = RegExp(r"(\+|\-)(\d+):(\d+)");

    sessionName = data['name'];
    id = data['id'];
    conferenceLink = data['conference_link'];
    coachId = data['coach_id'];
    coachName = data['coach_name'];
    programId = data['program_id'];
    timezone = data['timezone'];
    sessionStartTime =
        DateTime.parse(data['date'].toString().replaceAll(timezoneRemover, ""));
    sessionEndTime = DateTime.parse(
        data['finish_date'].toString().replaceAll(timezoneRemover, ""));
    description = data['description'];
    duration = Duration(seconds: data['duration_in_seconds']);
  }

  @override
  String toJson() {
    return jsonEncode({
      'session_name': sessionName,
      'id': id,
      'conference_link': conferenceLink,
      'program_id': programId,
      'description': description,
    });
  }
}

class Sessions extends MultipleItemsModel<Session> {
  @override
  Session model() => Session();
}

