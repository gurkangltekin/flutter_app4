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
          onTap: (){
            debugPrint("seçilen öğrenc: ${tumOgrenciler[index]._isim}");
            Toast.show("seçilen öğrenc: ${tumOgrenciler[index]._isim}", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          },
          onLongPress: (){
            debugPrint("uzun seçilen öğrenc: ${tumOgrenciler[index]._isim}");
            Toast.show("uzun seçilen öğrenc: ${tumOgrenciler[index]._isim}", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
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
}

class Ogrenci {
  String _isim;
  String _aciklama;
  bool _cinsiyet;

  Ogrenci(this._isim, this._aciklama, this._cinsiyet);
}
