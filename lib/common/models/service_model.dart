class ServiceModel {
  final String title;
  final String image;

  ServiceModel({required this.title, required this.image});

  static List<ServiceModel> mockList() {
    return [
       ServiceModel(
          title: 'Haircut for men', image: 'https://via.placeholder.com/64'),
      ServiceModel(
          title: 'Shave for men', image: 'https://via.placeholder.com/64'),
      ServiceModel(
          title: 'Facial for women', image: 'https://via.placeholder.com/64'),
      ServiceModel(
          title: 'Bleach for women', image: 'https://via.placeholder.com/64'),
      ServiceModel(
          title: 'Waxing for women', image: 'https://via.placeholder.com/64'),
   
    ];
  }
}
