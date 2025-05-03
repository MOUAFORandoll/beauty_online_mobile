class SalonModel {
  final String title;
  final String subtitle;
  final String image;
  final double rating;
  final double distance;

  SalonModel({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.rating,
    required this.distance,
  });

  static List<SalonModel> mockPopular() {
    return [
      SalonModel(
        title: 'Woodlands Hills Salon',
        subtitle: 'Haircut, Spa, Massage',
        image: 'https://via.placeholder.com/300x200',
        rating: 4.1,
        distance: 5.0,
      ),
      // Ajoute d'autres salons ici si besoin
    ];
  }

  static List<SalonModel> mockOffers() {
    return [
      SalonModel(
        title: 'Mounrich Spa Services',
        subtitle: 'Spa Salon',
        image: 'https://via.placeholder.com/300x200',
        rating: 4.1,
        distance: 5.0,
      ),
      // Autres salons avec offres ici
    ];
  }
}
