
import 'package:final_exam2/utils/db_helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  RxList<Map> dataList = <Map>[].obs;
  RxInt income = 0.obs;
  RxInt expense = 0.obs;
  RxInt total = 0.obs;
  Rx<DateTime> currentdate = DateTime.now().obs;
  RxList<Map> totalIncomeList = <Map>[].obs;
  RxList<Map> totalExpanseList = <Map>[].obs;

  Future<void> readData() async {
    dbHelper dbheler = dbHelper();
    dataList.value = await dbheler.readDb();
  }

  void deleteData(int id) {
    dbHelper dbhelper = dbHelper();
    dbhelper.deleteDb(id: id);
    readData();
  }

  void updateData(String category, String amount, String notes, int status,int id,String date,String paytype) {
    dbHelper dbhelper = dbHelper();
    dbhelper.updateDb(id: id, category: category, amount: amount, status: status, notes: notes, date: date, paytype: paytype);
    readData();
  }

  Future<void> incomeexpenseFilter(int status)
  async {
    dbHelper dbhelper = dbHelper();
    dataList.value = await dbhelper.incomeFilter(status: status);
  }

  Future<void> totalIncome()
  async {
    dbHelper dbhelper = dbHelper();
    totalIncomeList.value = await dbhelper.totalIncome();
  }

  Future<void> totalExpense()
  async {
    dbHelper dbhelper = dbHelper();
    totalExpanseList.value = await dbhelper.totalExpanse();
    int income = totalIncomeList[0]['SUM(amount)'];
  }
  // var payselect="cash 💵".obs;
  // RxList<String> paytype = <String>[
  //   "online 📱",
  //   "cash 💵",
  // ].obs;
  // void payType({required paytype})
  // {
  //   dbHelper dbhelper = dbHelper();
  //   dbhelper.payFiltrr(payType: paytype);
  //   readData();
  // }



}