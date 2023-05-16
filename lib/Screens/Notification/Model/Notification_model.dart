class NotificationService {
  final String title;
  final String desc;
  final String links;
  final String docs;

  NotificationService({required this.title,required this.desc,required this.links,required this.docs});

  factory NotificationService.fromJson(Map<String, dynamic> json) {
    return NotificationService(
      title: json['title'],
      desc: json['desc'],
      links: json['links'],
      docs: json['docs'],
    );
  }
}