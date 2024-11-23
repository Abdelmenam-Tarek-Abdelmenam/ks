class StringManger {
  static const int langIndex = 1;

  // static set setLanguage(int themeIndex) {
  //   langIndex = themeIndex;
  // }

  static const empty = "";

  // application info
  static String get appName => ["Key of Success", "Key of Success"][langIndex];
  static String get all => ["All", "الكل"][langIndex];
  static String get en => ["EN", "انجيزي"][langIndex];
  static String get ar => ["AR", "عربي"][langIndex];
  static String get system => ["System", "النظام"][langIndex];
  static String get dark => ["Dark", "مظلم"][langIndex];
  static String get light => ["Light", "مضئ"][langIndex];
  static String get warning => ["Warning", "تحذير"][langIndex];
  static String get none => ["none", "لا يوجد"][langIndex];
  static String get cancel => ["Cancel", "الغاء"][langIndex];
  static String get confirm => ["Confirm", "تاكيد"][langIndex];
  static String get no => ["No", "لا"][langIndex];
  static String get yes => ["Yes", "نعم"][langIndex];
  static String get photos => ["Photos", "صور"][langIndex];
  static String get noPhotos => ["No photos yet", "لا صور"][langIndex];
  static String get showMore => ["Show more", "رؤيه المزيد"][langIndex];
  static String get reviews => ["Reviews", "التقيمات"][langIndex];
  static String get review => ["Review", "التقيم"][langIndex];
  static String get addReview => ["Add Review", "اضافه تقيم"][langIndex];
  static String get priceUnit => ["EGP", "جنيه"][langIndex];
  static String get exitQ => [
        "Are you Sure you want Exit ?",
        "هل انت متاكد انك تريد المغادره؟"
      ][langIndex];

  // login view
  static String get emailAddress =>
      ["Email address", "البريد الاكتروني"][langIndex];
  static String get password => ["Password", "الرقم السري"][langIndex];
  static String get password2 =>
      ["Password Verification", "تاكيد الرقم السري"][langIndex];
  static String get signUp => ["Sign up", "انشاء حساب"][langIndex];
  static String get login => ["Login", "دخول الحساب"][langIndex];
  static String get submit => ["Submit", "تاكيد"][langIndex];
  static String get message => ["Message", "الرساله"][langIndex];
  static String get name => ["Name", "الاسم"][langIndex];
  static String get phone => ["Phone number", "رقم التليفون"][langIndex];
  static String get register => ["Register", "التسجيل"][langIndex];
  static String get wrongPasswords =>
      ["Passwords are not the same", "الرقم السري غير مطابق"][langIndex];
  static String get forgetPassword =>
      ["Forget Password", "نسيت الرقم السري"][langIndex];

  // landing Page
  static String get match => ["Play", "Talents Academy"][langIndex];
  static String get file => ["Play", "ملف اللاعب"][langIndex];
  static String get tournaments => ["Tournaments", "البطولات"][langIndex];
  static String get leaderBoard => ["Leader board", "ناشط رياضي"][langIndex];
  static String get about =>
      ["About", "تعرف علينا"][langIndex];


  // customer support
  static String get quickContact =>
      ["Quick Contact", "التواصل السريع"][langIndex];
  static String get chat => ["Chat Us", "راسلنا"][langIndex];
  static String get call => ["Call Us", "كلمنا"][langIndex];
  static String get email => ["Email Us", "راسلنا"][langIndex];

  // tournaments
  static String get noTournaments =>
      ["No tournaments active now", "لا يوجد مسابقات الان"][langIndex];

  // Products
  static String get add => ["Add", "اضافه"][langIndex];


  // matches
  static String get ground => ["Grounds", "الملاعب"][langIndex];
  static String get active => ["active", "الاشتراكات"][langIndex];
  static String get available => ["Available", "المتاح"][langIndex];
  static String get join => ["Join game", "التسجيل"][langIndex];
  static String get community => ["Community", "المتاح"][langIndex];
  static String get noGrounds =>
      ["No available ground now", "لا يوجد ملاعب متاحه"][langIndex];
  static String get noGyms =>
      ["No available gyms now", "لا يوجد صالات متاحه"][langIndex];
  static String get noCoaches =>
      ["No available coaches now", "لا يوجد مدربين متاحه"][langIndex];
  static String get noMatches =>
      ["No available matches now", "لا العاب مفتوحه"][langIndex];
  static String get freeToPlay => [
        "Are you free any time at any place to play ?",
        "هل انت متاح جميع الاوقات للعب في اي مكان"
      ][langIndex];

  // coaches
  static String get facilities => ["Facilities", "خدمات"][langIndex];

  // errors
  static String get contactsErrors => [
        "Can't launch this contact method",
        "لا يمكن الاتصال بهذه الطريقه"
      ][langIndex];
  static String get emptyReview =>
      ["Review can't be empty", "لا يمكنك ارسال تقيم فارغ"][langIndex];
}
