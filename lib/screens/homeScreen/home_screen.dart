import 'package:final_exam2/screens/homeController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Budget Tracker"),
        centerTitle: true,
        // backgroundColor: Colors.blue.shade700,
        backgroundColor: Colors.black,
      ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  total(),
                  SizedBox(
                    height: 5,
                  ),
                  incomeBox(),
                  Spacer(),
                  add(),
                ],
              ),
            ),
          ),
        ),
      );
  }


  Widget total() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(13),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Total",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(height: 5),
            Text(
              "${homeController.total.value}",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget incomeBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 60,
          width: 140,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              color: Colors.green.shade400,
              borderRadius: BorderRadius.circular(13)),
          child: Column(
            children: [
              Text(
                "Income",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              // Text(
              //   "${homeController.totalIncome()}",
              //   style: TextStyle(
              //       color: Colors.white, fontWeight: FontWeight.bold),
              // ),
            ],
          ),
        ),
        Container(
          height: 60,
          width: 140,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              color: Colors.red.shade400,
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Text(
                "Expense",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              // Text(
              //   "${homeController.totalExpense()}",
              //   style: TextStyle(
              //       color: Colors.white, fontWeight: FontWeight.bold),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget add() {
    return Container(
      height: 90,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed('/add');
            },
            child: Container(
              height: 60,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 2, color: Colors.black)),
              alignment: Alignment.center,
              child: Text(
                "Add Transaction",
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              homeController.readData();
              Get.toNamed('/transaction');
            },
            child: Container(
              height: 60,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 2)),
              alignment: Alignment.center,
              child: Text(
                "View Transaction",
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
