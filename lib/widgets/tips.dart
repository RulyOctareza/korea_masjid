class Tips {
  final int id;
  final String title;
  final String imageUrl;
  final String updatedAt;
  // final String url;

  Tips({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.updatedAt,
    // required this.url,
  });

  // factory Tips.fromMap(Map<String, dynamic> data, String id) {
  //   return Tips(
  //     id: ,
  //     title: data['title'],
  //     imageUrl: data['imageUrl'],
  //     updatedAt: data['updatedAt'],
  //    // url: data['url'],
  //   );
  // }
}
