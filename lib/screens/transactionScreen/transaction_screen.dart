import 'package:final_exam2/screens/homeController.dart';
import 'package:final_exam2/utils/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  HomeController homeController = Get.put(HomeController());
  TextEditingController txtamount = TextEditingController();
  TextEditingController txtcate = TextEditingController();
  TextEditingController txtdate = TextEditingController(
      text:
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}");
  TextEditingController txtpay = TextEditingController();
  TextEditingController txtnote = TextEditingController();
  TextEditingController txtstatus = TextEditingController();

  @override
  void initState() {
    dbHelper dbhelper = dbHelper();
    super.initState();
    homeController.readData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Transaction Screen"),
        centerTitle: true,
        // backgroundColor: Colors.blue.shade700,
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: () {
            Get.defaultDialog(
              title: "Get Your Filter",
              content: Column(
                children: [
                  InkWell(
                      onTap: () {
                        homeController.readData();
                        Get.back();
                      },
                      child: Text("All transaction")),
                  SizedBox(height: 7,),
                  InkWell(
                      onTap: () {
                        homeController.incomeexpenseFilter(1);
                        Get.back();
                      },child: Text("Income")),
                  SizedBox(height: 7,),
                  InkWell(onTap: () {
                    homeController.incomeexpenseFilter(0);
                    Get.back();
                  },child: Text("Expense")),
                ],
              ),
            );
          }, icon: Icon(Icons.filter_alt_rounded))
        ],

      ),
      body: Obx(
       () =>  ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return data(
              homeController.dataList[index]['id'],
              index,
              homeController.dataList[index]['amount'],
              homeController.dataList[index]['category'],
              homeController.dataList[index]['notes'],
              homeController.dataList[index]['status'],
            );
          },
          itemCount: homeController.dataList.length,
        ),
      ),
    ));
  }

  Widget data(int id, int index, String amount, String category, String notes,
      int status) {
    return Container(
      height: 100,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: status == 1 ? Colors.green.shade400 : Colors.red.shade400,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("$id"),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$category",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
              Text("\$ $amount",style: TextStyle(fontWeight: FontWeight.w600),),
              Text("$notes",style: TextStyle(fontWeight: FontWeight.w500),),
            ],
          ),
          IconButton(onPressed: () {
            txtcate = TextEditingController(
                text: '${homeController.dataList[index]['category']}');
            txtamount = TextEditingController(
                text: '${homeController.dataList[index]['amount']}');
            txtdate = TextEditingController(
                text: '${homeController.dataList[index]['date']}');
            txtpay = TextEditingController(
                text: '${homeController.dataList[index]['paytype']}');
            txtnote = TextEditingController(
                text: '${homeController.dataList[index]['notes']}');
            Get.defaultDialog(
              title: "Update your entry",
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: txtcate,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Category"),
                        fillColor: Colors.black),
                  ),SizedBox(height: 5,),
                  TextField(
                    controller: txtamount,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Amount"),
                        fillColor: Colors.black),
                  ),SizedBox(height: 5,),
                  TextField(
                    controller: txtdate,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Date"),
                        fillColor: Colors.black),
                  ),SizedBox(height: 5,),
                  TextField(
                    controller: txtnote,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Notes"),
                        fillColor: Colors.black),
                  ),SizedBox(height: 5,),
                  TextField(
                    controller: txtpay,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Paytypes"),
                        fillColor: Colors.black),
                  ),SizedBox(height: 5,),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: () {
                    int status = 1;
                    String category = txtcate.text;
                    String amount = txtamount.text;
                    String notes = txtnote.text;
                    String date = "${txtdate.text}";
                    String pay = txtpay.text;
                    homeController.updateData(
                        category,
                        amount,
                        notes,
                        status,
                        id,
                        date,
                        pay);
                    homeController.readData();
                    Get.back();
                  }, child: Text("Income"),style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade400),),
                  ElevatedButton(onPressed: () {
                    int status = 0;
                    String category = txtcate.text;
                    String amount = txtamount.text;
                    String notes = txtnote.text;
                    String date = "${txtdate.text}";
                    String paytype = txtpay.text;
                    homeController.updateData(
                        category,
                        amount,
                        notes,
                        status,
                        id,
                        date,
                        paytype);
                    homeController.readData();
                    Get.back();
                  }, child: Text("Expense"),style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade400),),
                ],
              ),
            );
          }, icon: Icon(Icons.edit)),

          IconButton(onPressed: () {
            int id = homeController.dataList[index]['id'];
            homeController.deleteData(id);
            homeController.readData();
          }, icon: Icon(Icons.delete)),
        ],
      ),
    );
  }
}
