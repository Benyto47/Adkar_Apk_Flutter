import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DetailPage extends StatelessWidget {
  //final TextAndPosition listItemDetail;
  final int numPage;
  final int totalPages;
  final String name;
  final String txtADisplay;
  const DetailPage(
      {Key? key,
      required this.numPage,
      required this.totalPages,
      required this.name,
      required this.txtADisplay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ListItem listItem=ModalRoute.of(context)!.settings.arguments as ListItem;

    // TextAndPosition listItemDetail = ModalRoute.of(context)!.settings.arguments as TextAndPosition;
    return Column(children: [

      Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text("★ "+numPage.toString() + " / " + totalPages.toString()+" ★",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.yellowAccent,
                        fontSize: 18, )),
              ),
              Text(
                txtADisplay,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 26, letterSpacing: 3
                ),
              ),
            ]),
          ),
        ),
      ),
    ]);
  }
}


