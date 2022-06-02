

import 'package:flutter/cupertino.dart';

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
String baseImage = 'https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=996&t=st=1653751505~exp=1653752105~hmac=3c88b8a51ac4fb7e73470f8f29da96108f8e0baba28e05d2c08c4190bd504e26';
String baseUrlPh = 'v2/fisherman2022/feeds/phmeter/data/last';
String baseUrlSound = 'v2/fisherman2022/feeds/sound/data/last';
String baseUrlGas = 'v2/fisherman2022/feeds/gas/data/last';
String baseUrlTurbidity = 'v2/fisherman2022/feeds/turbidity/data/last';
String baseKey = 'aio_QACU58XanxLgDPPV9RPqhRywhyKh';


String phRecords = 'https://io.adafruit.com/api/v2/fisherman2022/feeds/phmeter/data?x-aio-key=aio_QACU58XanxLgDPPV9RPqhRywhyKh';
String turbidityRecords = 'https://io.adafruit.com/api/v2/fisherman2022/feeds/turbidity/data?x-aio-key=aio_QACU58XanxLgDPPV9RPqhRywhyKh';
String soundRecords = 'https://io.adafruit.com/api/v2/fisherman2022/feeds/sound/data?x-aio-key=aio_QACU58XanxLgDPPV9RPqhRywhyKh';
String gasRecords = 'https://io.adafruit.com/api/v2/fisherman2022/feeds/gas/data?x-aio-key=aio_QACU58XanxLgDPPV9RPqhRywhyKh';
const defaultWidthSizeBox = SizedBox(
  width: 10,
);
const defaultHeightSizeBox = SizedBox(
  height: 10,
);
const defaultHeightSizeBox15 = SizedBox(
  height: 15,
);

