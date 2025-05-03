class PostModel {
  final String title;
  final String subtitle;
  final String image;
  final double rating;
  final double distance;

  PostModel({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.rating,
    required this.distance,
  });
  static List<PostModel> mockPopular() {
    return List.generate(30, (index) {
      return PostModel(
        title: 'Woodlands Hills Salon $index',
        subtitle: 'Haircut, Spa, Massage',
        image: 'https://picsum.photos/200/300',
        rating: 4.1,
        distance: 5.0,
      );
    });
  }
}
