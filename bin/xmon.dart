import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';

String bestBuy =
    'https://www.bestbuy.com/site/microsoft-xbox-series-s-512-gb-all-digital-console-disc-free-gaming-white/6430277.p?acampID=0&cmp=RMX&irclickid=V3EXlfUbTxyLRoT07OwzdzZ-UkEXCWTl1yD0UA0&irgwc=1&loc=Narrativ&mpid=376373&ref=198&skuId=6430277';

String walmart =
    'https://www.walmart.com/ip/Xbox-Series-S/606518560?irgwc=1&sourceid=imp_w%3ACXU5UbQxyLUPnwUx0Mo372UkEXCTUt1yD0UA0&veh=aff&wmlspartner=imp_1943169&clickid=w%3ACXU5UbQxyLUPnwUx0Mo372UkEXCTUt1yD0UA0&sharedid=&affiliates_ad_id=565706&campaign_id=9383';

String amazon =
    'https://www.amazon.com/Xbox-X/dp/B08G9J44ZN?tag=georiot-us-default-20&ascsubtag=tomsguide-us-1454379658992369000-20&geniuslink=true';

String gameStop =
    'https://www.gamestop.com/video-games/xbox-series-x/consoles/products/xbox-series-s-digital-edition/B224746K.html';

void main(List<String> arguments) async {
  Timer.periodic(Duration(seconds: 60), (_) async {
    check(bestBuy, '"Sold Out\\"}');
    check(walmart, 'This item is <b>out of stock</b>');
    check(amazon, 'Currently unavailable.');
    check(gameStop, '"availability":"Not Available"');
  });
}

void check(String url, String text) {
  get(Uri.parse(url))
      .then((value) => value.body.contains(text))
      .asStream()
      .where((event) => !event)
      .listen(
    (event) async {
      print(url);
      print('-' * 20);
      await Process.run(
        'terminal-notifier',
        [
          '-message',
          url,
          '-title',
          'Xbox',
          '-open',
          url,
          '-ignoreDnD',
          '-sound',
          'default'
        ],
      );
    },
  );
}
