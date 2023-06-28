import 'package:final_exam2/screens/addScreen/add_screen.dart';
import 'package:final_exam2/screens/transactionScreen/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/homeScreen/home_screen.dart';
void main()
{
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => HomeScreen(),),
        GetPage(name: '/add', page: () => AddScreen(),),
        GetPage(name: '/transaction', page: () => TransactionScreen(),),
      ],
    ),
  );
}