
import 'package:flutter/material.dart';

AppBar subAppBar(String a){
  return AppBar(
    toolbarHeight: 60,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:[Colors.blueAccent, Colors.teal.shade400],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
    ),
    title: Text(a, style: const TextStyle(
        color: Colors.white,
        fontFamily: "Roboto_bold",
        fontSize: 20,
        letterSpacing: 1
    ),),
    centerTitle: true,
    elevation: 0.0,
  );
}

Container ChooseChapter(String a) {
  return Container(
    alignment: AlignmentDirectional.center,
    margin: const EdgeInsets.only(top: 15),
    width: 220,
    height: 40,
    decoration:BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.deepOrange[50],
      boxShadow: [
        BoxShadow(
          color: Colors.green.withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 1), // changes position of shadow
        ),
      ],
    ),
    child:  Text(a, style: const TextStyle(
      color: Colors.deepOrangeAccent,
      fontSize: 20,
      fontFamily: "Roboto_bold",
    ),),
  );
}

Row btnName(bool a){
  if (a) {
    return Row (
      children: const [
        Icon(Icons.arrow_back_ios),
        SizedBox(width: 3),
        Text("Pre Chapter", style: (TextStyle(fontFamily: "Roboto_bold", fontSize: 20, fontStyle: FontStyle.italic)),)
      ],
    );
  } else {
    return Row (
      children: const [
        Text("Next Chapter", style: (TextStyle(fontFamily: "Roboto_bold", fontSize: 20, fontStyle: FontStyle.italic)),),
        SizedBox(width: 3),
        Icon(Icons.arrow_forward_ios_outlined),
      ],
    );
  }
}

ButtonStyle btnStyle(){
  return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.black26;
            }
            return Colors.green;
          }
      ),
      // foregroundColor is red for all states.
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)
              ||  states.contains(MaterialState.disabled)) {
            return 0;
          }
          return 5;
        },
      )
  );
}

BottomNavigationBarItem bottomNavigatorItem(IconData icon){
  return BottomNavigationBarItem(
      icon: Icon(icon, size: 30),
      title: Text(""),
      activeIcon: Icon(icon, size: 30, color: Colors.pink,),
  );

}