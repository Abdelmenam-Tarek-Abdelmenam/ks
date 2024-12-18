import 'package:url_launcher/url_launcher.dart';

import '../../presentation/shared/toast_helper.dart';

void launchMapsUrl(String? loc) async {
  if(loc !=null){
    // final Uri url =
    //   Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon');
    final Uri url =
      Uri.parse(loc);
  // if (await canLaunchUrl(url)) {
  await launchUrl(url).catchError((_){
      showToast("Can't launch Google maps");
      return false;
    });
  // } else {
  }
}
