part of 'catalogue_cubit.dart';

mixin CatalogueState on Equatable {}

class InitializingCatalogueState extends CubitLoadingState
    with CatalogueState {
  const InitializingCatalogueState() : super();
}

class CatalogueLoadedState extends CubitSuccessState with CatalogueState {
  final Catalogue catalogue;

  const CatalogueLoadedState(this.catalogue) : super();

  @override
  List<Object?> get props => [Catalogue];
}

class CatalogueLoadingState extends CubitLoadingState
    with CatalogueState {
  const CatalogueLoadingState() : super();
}
 
class CatalogueErrorState extends CubitErrorState with CatalogueState {
  CatalogueErrorState(super.error, [super.trace]);
}

class ShareCatalogueLoadingState extends CubitLoadingState with CatalogueState {
  const ShareCatalogueLoadingState() : super();
}




class ShareCatalogueSuccessState extends CubitInformationState with CatalogueState {
  final String shareLink;

  const ShareCatalogueSuccessState(this.shareLink);

  @override
  List<Object?> get props => [shareLink];
}


class LikeCatalogueLoadingState extends CubitLoadingState with CatalogueState {
  const LikeCatalogueLoadingState() : super();
}

class VueCatalogueLoadingState extends CubitLoadingState with CatalogueState {
  const VueCatalogueLoadingState() : super();
}
