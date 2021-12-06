class Publications_response {
  int userId;
  String title;
  String body;

  Publications_response({required this.userId, required this.title, required this.body});

 Publications_response.fromJson(Map<String, dynamic> json) :
    userId = json['userId'] ?? json['userId'],

    title = json['title'] ?? json['title'],
    body = json['body'] ?? json['body'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}