import 'package:adkar_flutter/pages/detail_page.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Importation du package

import '../model/text_position.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key}) : super(key: key);

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  // Liste des éléments du menu avec traduction
  var myMenuItems = <String>[
    'shareApp'.tr, // Partager l'application
    'evaluationApp'.tr, // Évaluer l'application
    'facebookPage'.tr, // Page Facebook
    'about'.tr // À propos
  ];

  int ind2 = 0;
  final Uri url = Uri.parse('https://www.facebook.com/palapps.ucas');

  // Map pour lier les traductions aux clés originales
  final Map<String, String> menuItemMapping = {
    'shareApp': 'shareApp'.tr,
    'evaluationApp': 'evaluationApp'.tr,
    'facebookPage': 'facebookPage'.tr,
    'about': 'about'.tr,
  };

  // Fonction pour obtenir la clé originale à partir de la traduction
  String getOriginalKey(String translatedValue) {
    return menuItemMapping.entries
        .firstWhere((entry) => entry.value == translatedValue,
            orElse: () => MapEntry('', ''))
        .key;
  }

  void onSelect(String item) {
    String originalKey = getOriginalKey(item);
    switch (originalKey) {
      case 'shareApp':
        Share.share("\n\nDownload our app Adkar on Playstore");
        break;

      case 'evaluationApp':
        launchUrl(url);
        break;

      case 'facebookPage':
        launchUrl(url);
        break;

      case 'about':
        Navigator.pushNamed(context, "/about");
        break;

      default:
        print('Item non reconnu');
    }
  }

  // Instance de FlutterTts
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false; // État de la lecture

  @override
  void initState() {
    super.initState();
    configureTts();
    // Ajouter l'écouteur pour l'événement de fin de lecture
    flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });
  }

  // Configure les paramètres TTS en fonction de la langue actuelle
  void configureTts() async {
    String currentLanguageCode = Get.locale?.languageCode ?? 'en';

    // Réglez la vitesse de la parole (0.0 à 1.0)
    await flutterTts.setSpeechRate(0.28); // Vitesse plus lente

    // Réglez la hauteur de la parole (0.5 à 2.0)
    await flutterTts.setPitch(1.0); // Tonalité normale

     List<dynamic> voices = await flutterTts.getVoices;
     print(voices);

    if (currentLanguageCode == 'ar') {
      // Définir la voix arabe
      await flutterTts.setLanguage("ar");
      await flutterTts
          .setVoice({"name": "ar-xa-x-ard-local", "locale": "ar-SA"});
    } else {
      // Définir la voix anglaise
      await flutterTts.setLanguage("en");
      await flutterTts
          .setVoice({"name": "en-us-x-sfg#male_2-local", "locale": "en-US"});
    }
  }

  // Fonction pour basculer entre lecture et pause
  void togglePlayback(String textToRead) async {
    if (isPlaying) {
      await flutterTts.pause();
    } else {
      await flutterTts.speak(textToRead);
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextAndPosition listItemDetail =
        ModalRoute.of(context)!.settings.arguments as TextAndPosition;

    String itemName = listItemDetail.name.contains("\n")
        ? listItemDetail.name.split("\n")[0] +
            " " +
            listItemDetail.name.split("\n")[1]
        : listItemDetail.name;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF0D0538),
        leading: IconButton(
          onPressed: () async {
            await Share.share("\n\nDownload our app Adkar on Playstore");
          },
          icon: Icon(Icons.share),
        ),
        title: Center(child: Text("titleAppbar".tr)),
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset("assets/images/ic_launcher.png"),
                  PopupMenuButton<String>(
                    onSelected: onSelect,
                    itemBuilder: (BuildContext context) {
                      return myMenuItems.map((String choice) {
                        return PopupMenuItem<String>(
                          child: Text(choice),
                          value: choice,
                        );
                      }).toList();
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Text(itemName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              constraints: BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/textswitcherbg.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: PageView.builder(
                reverse: true,
                itemCount: listItemDetail.textAAfficher.length,
                itemBuilder: (context, index) {
                  ind2 = index;
                  return DetailPage(
                    numPage: index + 1,
                    totalPages: listItemDetail.textAAfficher.length,
                    name: listItemDetail.name.contains("\n")
                        ? listItemDetail.name.split("\n")[0] +
                            " " +
                            listItemDetail.name.split("\n")[1]
                        : listItemDetail.name,
                    txtADisplay: listItemDetail.textAAfficher[index],
                  );
                },
              ),
            ),
          ),
          Container(
            height: 50,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () async {
                    await FlutterClipboard.copy(
                        listItemDetail.textAAfficher[ind2]);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("√ Copied")),
                    );
                  },
                  icon: Icon(Icons.copy),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () async {
                    await Share.share(listItemDetail.textAAfficher[ind2] +
                        "\n\nDownload our app Adkar on Playstore");
                  },
                  icon: Icon(Icons.share),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () async {
                    // Texte actuel à lire
                    String textToRead = listItemDetail.textAAfficher[ind2];

                    // Basculer entre lecture et pause
                    togglePlayback(textToRead);
                  },
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
