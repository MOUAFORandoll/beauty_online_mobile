import 'package:flutter/services.dart';

abstract class Assets {
  static const String _iconsDir = 'assets/icons/';
  static const String iconsApple = '${_iconsDir}apple.svg';
  static const String iconsGoogle = '${_iconsDir}google.svg';
  static const String iconsCamera = '${_iconsDir}camera.svg';
  static const String iconsArrow = '${_iconsDir}Arrow.svg';
  static const String iconsBookmark = '${_iconsDir}Bookmark.svg';
  static const String iconsCalendar = '${_iconsDir}Calendar.svg';
  static const String iconsComment = '${_iconsDir}Comment.svg';
  static const String iconsDirectionLeft = '${_iconsDir}DirectionLeft.svg';
  static const String iconsDirectionRight = '${_iconsDir}DirectionRight.svg';
  static const String iconsDirectionUp = '${_iconsDir}DirectionUp.svg';
  static const String iconsDirectionDown = '${_iconsDir}DirectionDown.svg';
  static const String iconsEdit = '${_iconsDir}Edit.svg';
  static const String iconsEmpty = '${_iconsDir}Empty.svg';
  static const String iconsError = '${_iconsDir}Error.svg';
  static const String iconsEvent = '${_iconsDir}Event.svg';
  static const String iconsLike = '${_iconsDir}Like.svg';
  static const String iconsLocalisation = '${_iconsDir}Localisation.svg';
  static const String iconsMore = '${_iconsDir}More.svg';
  static const String iconsOptions = '${_iconsDir}Options.svg';
  static const String iconsQuiz = '${_iconsDir}Quiz.svg';
  static const String iconsQuizList = '${_iconsDir}QuizList.svg';
  static const String iconsQuizLeaderboard = '${_iconsDir}QuizLeaderboard.svg';
  static const String iconsNotification = '${_iconsDir}Notification.svg';
  static const String iconsSearch = '${_iconsDir}Search.svg';
  static const String iconsSetting = '${_iconsDir}Setting.svg';
  static const String iconsShare = '${_iconsDir}Share.svg';
  static const String iconsSignal = '${_iconsDir}Signal.svg';
  static const String iconsTick = '${_iconsDir}Tick.svg';
  static const String iconsTime = '${_iconsDir}Time.svg';
  static const String iconsTrending = '${_iconsDir}Trending.svg';
  static const String iconsbeauty = '${_iconsDir}Trending.svg';
  static const String iconsBlock = '${_iconsDir}Block.svg';
  static const String iconsFollow = '${_iconsDir}Follow.svg';
  static const String iconsLogout = '${_iconsDir}Logout.svg';
  static const String iconDelete = '${_iconsDir}Delete.svg';
  static const String iconMoreBig = '${_iconsDir}more_big.svg';
  static const String iconPause = '${_iconsDir}Pause.svg';
  static const String iconPlay = '${_iconsDir}Play.svg';

  static const String _imagesDir = 'assets/images/';
  static const String defaultAvatar = '${_imagesDir}default_avatar.svg';
  static const String iconMedalFirst = '${_imagesDir}icon_medal_first.png';
  static const String iconMedalSecond = '${_imagesDir}icon_medal_second.png';
  static const String iconMedalThird = '${_imagesDir}icon_medal_third.png';
  static const String iconPictureAdd = '${_imagesDir}Icon_picture_add.svg';
  static const String onBoardingImage = '${_imagesDir}onboarding.svg';
  static const String onBoardingImage2 = '${_imagesDir}onboarding.png';
  static const String pinPro = '${_imagesDir}pin_pro.png';

  static const String _logoDir = 'assets/logo/';
  static const String _logobeauty = '${_logoDir}logo.png';
  static const String _iconTransparentbeauty =
      '${_logoDir}icon_transparent.png';
  static const String _logoKonosekaiDir = 'assets/logo/konosekai/';
  static const String _logoKonosekai = '${_logoKonosekaiDir}logo.png';
  static const String _iconTransparentKonosekai =
      '${_logoKonosekaiDir}icon_transparent.png';

  static String get logo => _logobeauty;

  static String get iconTransparent => _iconTransparentbeauty;

  static const String fontsFamilyARCO = 'ARCO';
  static const String fontsPlusJakartaSans = 'Plus Jakarta Sans';
}
