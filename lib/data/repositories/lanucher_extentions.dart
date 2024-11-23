import 'package:url_launcher/url_launcher.dart';

import '../../presentation/shared/toast_helper.dart';

void launchMapsUrl(double lat, double lon) async {
  final Uri url =
      Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon');
  // if (await canLaunchUrl(url)) {
    await launchUrl(url).catchError((_){
      showToast("Can't launch Google maps");
      return false;
    });
  // } else {
  // }
}
