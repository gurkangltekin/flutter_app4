import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class EtkinListeOrnek extends StatelessWidget {
  List<Ogrenci> tumOgrenciler = [];

  @override
  Widget build(BuildContext context) {
    ogrenciVerisiCek();

    return ListView.separated(
      separatorBuilder: (context, index) => (index + 1) % 5 == 0
          ? Container(
              color: Colors.black,
              height: 4,
            )
          : Container(),
      itemCount: 25,
      itemBuilder: (context, index) => Card(
        elevation: 4,
        color: tumOgrenciler[index]._cinsiyet
            ? Colors.pink.shade100
            : Colors.blue.shade100,
        child: ListTile(
          leading: Icon(Icons.person),
          title: Text(tumOgrenciler[index]._isim),
          subtitle: Text(tumOgrenciler[index]._aciklama),
          trailing: Icon(Icons.keyboard_arrow_down),
          onTap: () {
            debugPrint("seçilen öğrenci: ${tumOgrenciler[index].toString()}");
            toastMesajGoster(context, index, false);
          },
          onLongPress: () {
            debugPrint(
                "uzun seçilen öğrenci: ${tumOgrenciler[index].toString()}");
            toastMesajGoster(context, index, true);
            alertDialogGoster(context, index);
          },
        ),
      ),
    );
  }

  void ogrenciVerisiCek() {
    tumOgrenciler = List.generate(
      300,
      (index) => Ogrenci(
          "${index + 1}.öğrencinin adı",
          "${index + 1}.öğrencinin açıklaması",
          (index + 1) % 2 == 0 ? true : false),
    );
  }

  void alertDialogGoster(BuildContext context, int index) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Alert Diyalog Başlığı"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  alertDiyalogIcerigi(tumOgrenciler[index].toString()),
                ],
              ),
            ),
            actions: <Widget>[
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text("Tamam"),
                    onPressed: () {

                    },
                  ),
                  RaisedButton(
                    child: Text(
                      "Kapat",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.red,
                  ),
                ],
              )
            ],
          );
        });
  }

  void toastMesajGoster(BuildContext context, int index, bool uzunBasilma) {
    Toast.show(
        uzunBasilma
            ? "uzun basılarak seçilen öğrenci: ${tumOgrenciler[index].toString()}"
            : "seçilen öğrenci: ${tumOgrenciler[index].toString()}",
        context,
        duration: 5,
        gravity: Toast.BOTTOM);
  }

  Text alertDiyalogIcerigi(String icerik){
    return Text(icerik);
  }
}

class Ogrenci {
  String _isim;
  String _aciklama;
  bool _cinsiyet;

  Ogrenci(this._isim, this._aciklama, this._cinsiyet);

  @override
  String toString() {
    return 'Ogrenci ismi: $_isim, açıklaması: $_aciklama, cinsiyeti: $_cinsiyet}';
  }
}
