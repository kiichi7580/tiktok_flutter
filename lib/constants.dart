import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_flutter/controllers/auth_controller.dart';
import 'package:tiktok_flutter/views/screens/add_video_screen.dart';
import 'package:tiktok_flutter/views/screens/home_screen.dart';
import 'package:tiktok_flutter/views/screens/video_screen.dart';

// page関連
List pages = [
  VideoScreen(),
  Text('2'),
  AddVideoScreen(),
  Text('4'),
  Text('5'),
];

// color関連
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// firebase関連
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

// controller関連
var authController = AuthController.instance;
