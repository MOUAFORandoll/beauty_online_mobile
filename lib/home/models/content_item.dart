class ContentItem {
  final String id;
  final String imageUrl;
  final String? title;
  final bool isMultiImage;
  final bool isSponsored;
  final String? sponsorName;
  final String? sponsorLogo;
  final bool hasInstallButton;

  ContentItem({
    required this.id,
    required this.imageUrl,
    this.title,
    this.isMultiImage = false,
    this.isSponsored = false,
    this.sponsorName,
    this.sponsorLogo,
    this.hasInstallButton = false,
  });
}
