
import 'model.dart';

class TimeSlotModel extends Model {
  late DateTime startTime, endTime;

  @override
  void fromJson(Map<String, dynamic> data) {
    startTime = DateTime.parse(data['start_time']);
    endTime = DateTime.parse(data['end_time']);
  }
}

class TimeSlotsModel extends MultipleItemsModel<TimeSlotModel> {
  @override
  TimeSlotModel model() => TimeSlotModel();
}

