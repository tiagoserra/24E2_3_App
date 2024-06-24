import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  String? message;
  String? token;

  final firebaseAuth = FirebaseAuth.instance;

  final _url = 'https://identitytoolkit.googleapis.com/v1/';
  final _resource = 'accounts:'; // signUp // signInWithPassword
  final _apiKey = '?key=AIzaSyDomLYibm8hTbVfdp47o1_hWgA_3lOMWmo';

  Future<bool> authRequest(String email, String password, String action) async {
    String sUri = '$_url$_resource$action$_apiKey';
    Uri uri = Uri.parse(sUri);
    var response = await http.post(uri, body: {
      'email': email,
      'password': password,
      'returnSecureToken': 'true'
    });
    var resp = jsonDecode(response.body);
    if (response.statusCode == 200) {
      message = "Usuário cadastrado com sucesso!";
      token = resp["idToken"];
      return true;
    } else {
      message = "Erro ao cadastrar Usuário!";
      return false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      token = userCredential.credential?.token.toString();
      message = "Usuário cadastrado com sucesso!";
      return true;
    } on FirebaseAuthException catch (e) {
      message = "Erro ao cadastrar Usuário!";
      print(e.code);
      print(e.message);
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      token = userCredential.credential?.token.toString();
      return true;
    } on FirebaseAuthException catch (e) {
      message = "Erro ao autenticar o Usuário!";
      print(e.code);
      print(e.message);
      return false;
    }
  }
}