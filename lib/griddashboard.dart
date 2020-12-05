import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'VistaChat.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Reportes",
      //subtitle: "March, Wednesday",
      //event: "3 Events",
      img: "assets/images/PDF.png");

  Items item2 = new Items(
      title: "Opciones de Administrador",
      //subtitle: "March, Wednesday",
      //event: "3 Events",
      img: "assets/settings.png");

  Items item3 = new Items(
      title: "Configuración del chat",
      //subtitle: "March, Wednesday",
      //event: "3 Events",
      img: "assets/images/chat.png");

  Items item4 = new Items(
      title: "Historial de conversaciones",
      //subtitle: "March, Wednesday",
      //event: "3 Events",
      img: "assets/images/chat.png");

  Items item5 = new Items(
      title: "Permisos y visualización",
      //subtitle: "March, Wednesday",
      //event: "3 Events",
      img: "assets/images/permiso.png");

  Items item6 = new Items(
      title: "Acerca de...",
      //subtitle: "March, Wednesday",
      //event: "3 Events",
      img: "assets/images/info.png");

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    //return Scaffold(
    //  backgroundColor: Color(0xff392850),
    //);
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myList.map((data) {
          return Container(
            decoration: BoxDecoration(
                color: Color(color), borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new InkWell(
                  child: Image.asset(
                    data.img,
                    width: 42,
                  ),
                  onTap: () {
                    print("Clicked container");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VistaChat()),
                    );
                  },
                ),
                //Image.asset(
                //  data.img,
                //  width: 42,
                //),
                SizedBox(
                  height: 14,
                ),
                Text(
                  data.title,
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ),
                //SizedBox(
                //  height: 8,
                //),
                //Text(
                //  data.subtitle,
                //  style: GoogleFonts.openSans(
                //      textStyle: TextStyle(
                //          color: Colors.white38,
                //          fontSize: 10,
                //          fontWeight: FontWeight.w600)),
                //),
                //SizedBox(
                //  height: 14,
                //),
                //Text(
                //  data.event,
                //  style: GoogleFonts.openSans(
                //      textStyle: TextStyle(
                //          color: Colors.white70,
                //          fontSize: 11,
                //          fontWeight: FontWeight.w600)),
                //),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class Items {
  String title;
  //String subtitle;
  //String event;
  String img;
  //Items({this.title, this.subtitle, this.event, this.img});
  Items({this.title, this.img});
}
