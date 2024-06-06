import 'package:adkar_flutter/model/item.dart';
import 'package:adkar_flutter/model/text_position.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ListViewItem extends StatelessWidget {
  final ListItem listItem;
  const ListViewItem({Key? key, required this.listItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Obtenir la locale actuelle
    Locale currentLocale = Get.locale ?? Locale('en');

    // Vérifier si la langue principale de la locale est l'arabe
    bool isArabic = currentLocale.languageCode == 'arb';

    return ListTile(
      title: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: 100,
        color: const Color(0xFFFF0D0538),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
          children :[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(listItem.name,
                    textAlign: TextAlign.center,
                    //overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: isArabic ? FontWeight.bold : FontWeight.normal,
                        color: Colors.white,
                        fontSize: 23)
                  ),
                ],
              ),
            ),

            Card(
              child: Image.asset(
                listItem.image,
                fit: BoxFit.cover,
              ),
              elevation: 10,
              margin: EdgeInsets.only(left: 30),
              color: const Color(0xFFFF0D0538),
            ),
      ]
        ),
      ),

      onTap: () {
       var listItemDetail = TextAndPosition(numPage: 1, name: listItem.name, textAAfficher: listItem.txtToShow);
        Navigator.pushNamed(context, "/details", arguments: listItemDetail);
      },
    );
  }
}
