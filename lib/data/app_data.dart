import 'package:adkar_flutter/services/dictionary.dart';
import 'package:get/get.dart';
import 'package:adkar_flutter/model/item.dart';



List<String> trList(String key) {
  final locale = Get.locale?.languageCode ?? 'en';
  final languageTranslation = LanguageTranslation();
  return languageTranslation.listKeys[locale]?[key] ?? [];
}

final ListItem  MorningAzkar =  ListItem(id: 1, name: "MorningAzkarName".tr, image: "assets/images/piclistone.png", txtToShow:  trList('MorningAzkartxtToShow'),
);

final ListItem NightAzkar = ListItem(id: 2, name: "NightAzkarName".tr, image: "assets/images/piclisttwo.png", txtToShow: trList('NightAzkartxtToShow'));


final ListItem  SleepAzkar = ListItem(id: 3, name: "SleepAzkarName".tr , image: "assets/images/nawm.png", txtToShow:  trList('NightAzkartxtToShow'));

final ListItem  Wodo2Azkar = ListItem(id: 4, name: "Wodo2AzkarName".tr , image: "assets/images/wodo2.png", txtToShow: trList('Wodo2AzkartxtToShow'));

final ListItem SalatAdkar = ListItem(id: 5, name:"SalatAdkarName".tr , image: "assets/images/after_salat.png", txtToShow: trList('SalatAdkartxtToShow'));

final ListItem AdanAdkar = ListItem(id: 6, name:"AdanAdkarName".tr , image: "assets/images/listen_adan.png", txtToShow: trList('AdanAdkartxtToShow'));

final ListItem GoMosqueAdkar = ListItem(id: 7, name:'GoMosqueAdkarName'.tr , image: "assets/images/go_mosque.png", txtToShow: trList('GoMosqueAdkartxtShow'));

final ListItem EnterMosqueAdkar = ListItem(id: 8, name: 'EnterMosqueAdkarName'.tr , image: "assets/images/enter_mosque.png", txtToShow: trList('EnterMosqueAdkartxtShow'));

final ListItem OutMosqueAdkar = ListItem(id: 9, name: 'OutMosqueAdkarName'.tr , image: "assets/images/out_mosque.png", txtToShow: trList('OutMosqueAdkartxtShow'));

final ListItem EnterHouseAdkar = ListItem(id: 10, name:'EnterHouseAdkarName'.tr , image: "assets/images/enter_house.png", txtToShow: trList('EnterHouseAdkartxtShow'));

final ListItem OutHouseAdkar = ListItem(id: 11, name: 'OutHouseAdkarName'.tr , image: "assets/images/go_house.png", txtToShow: trList('OutHouseAdkartxtShow'));

final ListItem Isti9adAdkar = ListItem(id: 12, name: 'Isti9adAdkarName'.tr , image: "assets/images/piclistfour.png", txtToShow: trList('Isti9adAdkartxtShow'));

final ListItem RizkAdkar = ListItem(id: 13, name: 'RizkAdkarName'.tr, image: "assets/images/rizk.png", txtToShow: trList('RizkAdkartxtShow'));

final ListItem FarajAdkar = ListItem(id: 14, name: 'FarajAdkarName'.tr , image: "assets/images/faraj.png", txtToShow: trList('FarajAdkartxtShow'));

final ListItem SafarAdkar = ListItem(id: 15, name: 'SafarAdkarName'.tr, image: "assets/images/safar.png", txtToShow: trList('SafarAdkartxtShow'));

final ListItem DeathAdkar = ListItem(id: 16, name: 'DeathAdkarName'.tr , image: "assets/images/death2.png", txtToShow: trList('DeathAdkartxtShwo'));

final ListItem InfoMuslim = ListItem(id: 17, name: 'InfoMuslimName'.tr, image: "assets/images/nasa2i7.png", txtToShow: trList('InfoMuslimtxtShow'));
