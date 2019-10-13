import 'package:agenda_contato_flutter/screen/contato_screen.dart';
import 'package:agenda_contato_flutter/screen/principal_screen.dart';
import 'package:flutter/material.dart';

void main(){
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PrincipalScreen(),
    ),
  );
}