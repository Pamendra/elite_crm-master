



abstract class ServiceEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


class onPressedEvent extends ServiceEvent{
   String headcode;
   String train_uid;
   String origin_location;
   String destination_location;
   String origin_time;
   String destination_time;
   String ota;
   String otd;
   String boarding;
   String alightning;
   String delayed;
   String comments;
   // String location_id;
   // String schedule_id;
   String cancelled;
   // String origin_tiploc;
   // String destination_tiploc;
   String toc;
   String arrival_time;
   String departure_time;
   String date_from;
   String date_to;
   String result_source;
   String platform;
   String station;

   onPressedEvent(
   {
   required this.headcode,
   required this.train_uid,
   required this.origin_location,
   required this.destination_location,
   required this.origin_time,
   required this.destination_time,
   required  this.ota,
   required this.otd,
   required this.boarding,
   required this.alightning,
   required this.delayed,
   required this.comments,
   // required this.location_id,
   // required this.schedule_id,
   required this.cancelled,
   // required this.origin_tiploc,
   // required this.destination_tiploc,
   required this.toc,
      required this.arrival_time,
      required this.departure_time,
      required this.date_from,
      required this.date_to,
      required this.result_source,
      required this.platform,
      required this.station
   });
   }
