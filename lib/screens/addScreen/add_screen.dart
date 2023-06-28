import 'package:final_exam2/screens/homeController.dart';
import 'package:final_exam2/utils/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController txtamount = TextEditingController();
  TextEditingController txtcate = TextEditingController();
  TextEditingController txtdate = TextEditingController(
      text:
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}");
  TextEditingController txtpay = TextEditingController();
  TextEditingController txtnote = TextEditingController();
  TextEditingController txtstatus = TextEditingController();

  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    dbHelper dbhelper = dbHelper();
    dbhelper.checkDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Enter your transaction"),
          centerTitle: true,
          // backgroundColor: Colors.blue.shade700,
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: txtcate,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      label: Text("Category")),
                ),SizedBox(height: 15,),
                TextField(
                  controller: txtamount,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      label: Text("Amount")),
                ),SizedBox(height: 15,),
                Container(
                  height: 60,
                  width: 395,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() => Text(
                            "${homeController.currentdate.value.day}/${homeController.currentdate.value.month}/${homeController.currentdate.value.year}")),
                      ),
                      IconButton(
                          onPressed: () async {
                            homeController.currentdate.value =
                                (await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2001),
                                    lastDate: DateTime(2030)))!;
                          },
                          icon: Icon(Icons.calendar_month_outlined)),
                    ],
                  ),
                ),SizedBox(height: 15,),
                TextField(
                  controller: txtnote,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      label: Text("Notes")),
                ),SizedBox(height: 15,),
                TextField(
                  controller: txtpay,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      label: Text("Paytype")),
                ),
                SizedBox(height: 35,),
                ElevatedButton(
                  onPressed: () {
                    dbHelper dbhelper = dbHelper();
                    dbhelper.insertDb(
                      amount: txtamount.text,
                      category: txtcate.text,
                      status: 1,
                      notes: txtnote.text,
                      date: txtdate.text,
                      paytype: txtpay.text,
                    );
                    int i = 0;
                    for (i = 0; i < homeController.dataList.length; i++) {
                      int status =
                      int.parse(homeController.dataList[i]['status']);
                      if (status == 1) {
                        int amount =
                        int.parse(homeController.dataList[i]['amount']);
                        homeController.total.value =
                            homeController.total.value + amount;
                        homeController.income.value =
                            homeController.income.value + amount;
                      }
                    }
                    Get.back();
                  },
                  child: Text("Income"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade400),
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: () {
                    dbHelper dbhelper = dbHelper();
                    dbhelper.insertDb(
                        amount: txtamount.text,
                        category: txtcate.text,
                        status: 0,
                        notes: txtnote.text,
                        date: txtdate.text,
                        paytype: txtpay.text);
                    int i = 0;
                    for (i = 0; i < homeController.dataList.length; i++) {
                      int status =
                      int.parse(homeController.dataList[i]['status']);
                      if (status == 0) {
                        int amount =
                        int.parse(homeController.dataList[i]['amount']);
                        homeController.total.value =
                            homeController.total.value - amount;
                        homeController.expense.value =
                            homeController.expense.value + amount;
                      }
                    }
                    Get.back();
                  },
                  child: Text("Expense"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
