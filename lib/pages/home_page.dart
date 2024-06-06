import 'package:adkar_flutter/model/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/app_data.dart';
import 'list_view_item.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String selectedLanguage; // Langue par défaut

  @override
  void initState() {
    super.initState();
    selectedLanguage = Get.locale?.languageCode ??
        'arb'; // Utilise la langue actuellement sélectionnée par GetX
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final value = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content:  Text("logout".tr),
                  actions: <Widget>[
                    TextButton(
                      child:  Text("no".tr),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    TextButton(
                      child:  Text("yes".tr),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                );
              });

          return value == true;
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFFF0D0538),
          appBar: AppBar(
            title: Text("titleAppbar".tr,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24)),
            backgroundColor: const Color(0xFFFF0D0538),
            actions: [
               Text(
                selectedLanguage.toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.language), // Icône de sélection de langue
                onSelected: (value) {
                  setState(() {
                    selectedLanguage = value;
                  });
                  Get.updateLocale(Locale(value));
                },
                itemBuilder: (BuildContext context) => [
                   PopupMenuItem(
                    value: 'arb',
                    child: Row(
                      children: [
                        Image.asset('assets/images/arb.png',  width: 24, height: 24),
                        const SizedBox(width: 10),
                        Text(
                          'Arabic',
                          style: TextStyle(
                            color: selectedLanguage == 'arb'
                                ? Colors.blue.shade900
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                   PopupMenuItem(
                    value: 'en',
                    child: Row(
                      children: [
                        Image.asset('assets/images/eng.png',  width: 24, height: 24),
                         const SizedBox(width: 10),
                        Text(
                          'English',
                          style: TextStyle(
                            color: selectedLanguage == 'en'
                                ? Colors.blue.shade900
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: Container(
            //color: const Color(0xFFFF0D0538),
            margin: EdgeInsets.only(top: 20),
            child: ListView(
              shrinkWrap: true,
              children:  [
                ListViewItem(listItem: ListItem(
                  id: 1,
                  name: "MorningAzkarName".tr,
                  image: "assets/images/piclistone.png",
                  txtToShow: trList('MorningAzkartxtToShow'),
                )),
                ListViewItem(listItem: ListItem(
                  id: 2,
                  name: "NightAzkarName".tr,
                  image: "assets/images/piclisttwo.png",
                  txtToShow: trList('NightAzkartxtToShow'),
                )),
                ListViewItem(listItem: ListItem(
                  id: 3,
                  name: "SleepAzkarName".tr,
                  image: "assets/images/nawm.png",
                  txtToShow: trList('NightAzkartxtToShow'),
                  )),
                ListViewItem(listItem: ListItem(
                  id: 4,
                  name: "Wodo2AzkarName".tr,
                  image: "assets/images/wodo2.png",
                  txtToShow: trList('Wodo2AzkartxtToShow'))),
                ListViewItem(listItem: ListItem(
                  id: 5,
                  name: "SalatAdkarName".tr,
                  image: "assets/images/after_salat.png",
                  txtToShow: trList('SalatAdkartxtToShow'))),
                ListViewItem(listItem: ListItem(
                  id: 6,
                  name: "AdanAdkarName".tr,
                  image: "assets/images/listen_adan.png",
                  txtToShow: trList('AdanAdkartxtToShow')),),
                ListViewItem(listItem: ListItem(
                  id: 7,
                  name: 'GoMosqueAdkarName'.tr,
                  image: "assets/images/go_mosque.png",
                  txtToShow: trList('GoMosqueAdkartxtShow'))),
                ListViewItem(listItem: ListItem(
                  id: 8,
                  name: 'EnterMosqueAdkarName'.tr,
                  image: "assets/images/enter_mosque.png",
                  txtToShow: trList('EnterMosqueAdkartxtShow'))),
                ListViewItem(listItem: ListItem(
                  id: 9,
                  name: 'OutMosqueAdkarName'.tr,
                  image: "assets/images/out_mosque.png",
                  txtToShow: trList('OutMosqueAdkartxtShow'))),
                ListViewItem(listItem: ListItem(
                  id: 10,
                  name: 'EnterHouseAdkarName'.tr,
                  image: "assets/images/enter_house.png",
                  txtToShow: trList('EnterHouseAdkartxtShow'))),
                ListViewItem(listItem: ListItem(
                  id: 11,
                  name: 'OutHouseAdkarName'.tr,
                  image: "assets/images/go_house.png",
                  txtToShow: trList('OutHouseAdkartxtShow'))),
                ListViewItem(listItem: ListItem(
                  id: 12,
                  name: 'Isti9adAdkarName'.tr,
                  image: "assets/images/piclistfour.png",
                  txtToShow: trList('Isti9adAdkartxtShow'))),
                ListViewItem(listItem: ListItem(
                  id: 13,
                  name: 'RizkAdkarName'.tr,
                  image: "assets/images/rizk.png",
                  txtToShow: trList('RizkAdkartxtShow'))),
                ListViewItem(listItem: ListItem(
                  id: 14,
                  name: 'FarajAdkarName'.tr,
                  image: "assets/images/faraj.png",
                  txtToShow: trList('FarajAdkartxtShow'))),
                ListViewItem(listItem: ListItem(
                  id: 15,
                  name: 'SafarAdkarName'.tr,
                  image: "assets/images/safar.png",
                  txtToShow: trList('SafarAdkartxtShow'))),
                ListViewItem(listItem: ListItem(
                  id: 16,
                  name: 'DeathAdkarName'.tr,
                  image: "assets/images/death2.png",
                  txtToShow: trList('DeathAdkartxtShwo'))),
                ListViewItem(listItem: ListItem(
                  id: 17,
                  name: 'InfoMuslimName'.tr,
                  image: "assets/images/nasa2i7.png",
                  txtToShow: trList('InfoMuslimtxtShow'))),
              ],
            ),
          ),

/*أدعية            وأذكار              المسلم*/
        ));
  }
}
