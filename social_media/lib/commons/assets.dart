class SocialMediaAssets {
  SocialMediaAssets._();
  static const String PACKAGE_NAME = 'socialmediaapp';
  static const String _PREFIX = 'assets';
  static const String _IMG_PNG_PATH = '$_PREFIX/images/png';
  static const String _IMG_SVG_PATH = '$_PREFIX/images/svg';

  static String _getImgPng(String name) {
    List<String> split = name.split('.');
    assert(split.last.toLowerCase() == 'png');

    return '$_IMG_PNG_PATH/$name';
  }

  static String _getImgSvg(String name) {
    List<String> split = name.split('.');
    assert(split.last.toLowerCase() == 'svg');
    return '$_IMG_SVG_PATH/$name';
  }

  //PNG
  static String get logoBlack => _getImgPng('logo-black.png');

  static String get logoWhite => _getImgPng('logo-white.png');

  static String get logo => _getImgPng('logo.png');

  //SVG
  static String get addRounded => _getImgSvg('add_rounded.svg');

  static String get add => _getImgSvg('add.svg');

  static String get camera => _getImgSvg('camera.svg');

  static String get chatIcon => _getImgSvg('chat-icon.svg');

  static String get gallery => _getImgSvg('gallery.svg');

  static String get gif => _getImgSvg('gif.svg');

  static String get homeIcon => _getImgSvg('home_icon.svg');

  static String get location => _getImgSvg('location.svg');

  static String get messageIcon => _getImgSvg('message-icon.svg');

  static String get mobileNewPosts => _getImgSvg('mobile-new-posts.svg');

  static String get movieReel => _getImgSvg('movie_reel.svg');

  static String get newMessage => _getImgSvg('new-message.svg');

  static String get notificationIcon => _getImgSvg('notification-icon.svg');

  static String get sendIcon => _getImgSvg('send-icon.svg');

  static String get undrawForgotPassword =>
      _getImgSvg('undraw_forgot_password.svg');

  static String get undrawOpenedEmail => _getImgSvg('undraw_opened_email.svg');

  static String get undrawPostOnline => _getImgSvg('undraw_post_online.svg');

  static String get undrawSocialInfluencer =>
      _getImgSvg('undraw_social_influencer.svg');

  static String get withoutPostsHome => _getImgSvg('without-posts-home.svg');
}
