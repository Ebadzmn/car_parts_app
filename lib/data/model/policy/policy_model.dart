class PolicyModel {
  final String title;
  final String content;
  final bool? isActive;

  PolicyModel({
    required this.title,
    required this.content,
    this.isActive,
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) {
    return PolicyModel(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      isActive: json['isActive'],
    );
  }
}
