import 'dart:io';
import 'package:spending_management/constants/function/get_data_spending.dart';
import 'package:spending_management/models/spending.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:spending_management/models/user.dart' as myuser;

class SpendingFirebase {
  static Future addSpending(Spending spending) async {
    var firestoreSpending =
        FirebaseFirestore.instance.collection("spending").doc();

    var firestoreData = FirebaseFirestore.instance
        .collection("data")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    if (spending.image != null) {
      spending.image = await uploadImage(
          folder: "spending",
          name: "${firestoreSpending.id}.png",
          image: File(spending.image!));
    }

    await firestoreSpending.set(spending.toMap());

    await firestoreData.get().then((value) {
      List<String> dataSpending = [];
      if (value.exists) {
        var data = value.data() as Map<String, dynamic>;
        if (data[DateFormat("MM_yyyy").format(spending.dateTime)] != null) {
          dataSpending = (data[DateFormat("MM_yyyy").format(spending.dateTime)]
                  as List<dynamic>)
              .map((e) => e.toString())
              .toList();
          dataSpending.add(firestoreSpending.id);
          firestoreData.update(
              {DateFormat("MM_yyyy").format(spending.dateTime): dataSpending});
        } else {
          dataSpending.add(firestoreSpending.id);
          data.addAll(
              {DateFormat("MM_yyyy").format(spending.dateTime): dataSpending});
          firestoreData.set(data);
        }
      } else {
        dataSpending.add(firestoreSpending.id);
        firestoreData.set(
            {DateFormat("MM_yyyy").format(spending.dateTime): dataSpending});
      }
    });
  }

  static Future updateSpending(
    Spending spending,
    DateTime oldDay,
    File? image,
    bool check,
  ) async {
    var firestoreSpending =
        FirebaseFirestore.instance.collection("spending").doc(spending.id);

    var firestoreData = FirebaseFirestore.instance
        .collection("data")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    if (image != null) {
      spending.image = await uploadImage(
          folder: "spending",
          name: "${firestoreSpending.id}.png",
          image: image);
    } else if (check) {
      await FirebaseStorage.instance
          .ref()
          .child("spending/${spending.id}.png")
          .delete();
      spending.image = null;
    }

    firestoreSpending.update(spending.toMap());

    await firestoreData.get().then((value) {
      List<String> dataSpending = [];
      var data = value.data() as Map<String, dynamic>;
      if (!isSameMonth(spending.dateTime, oldDay)) {
        //xóa cái id cũ ra khỏi tháng đó
        dataSpending =
            (data[DateFormat("MM_yyyy").format(oldDay)] as List<dynamic>)
                .map((e) => e.toString())
                .toList();
        dataSpending.remove(spending.id!);
        firestoreData
            .update({DateFormat("MM_yyyy").format(oldDay): dataSpending});

        // thêm id vào tháng mới
        if (data[DateFormat("MM_yyyy").format(spending.dateTime)] != null) {
          dataSpending = (data[DateFormat("MM_yyyy").format(spending.dateTime)]
                  as List<dynamic>)
              .map((e) => e.toString())
              .toList();
          dataSpending.add(spending.id!);
          firestoreData.update(
              {DateFormat("MM_yyyy").format(spending.dateTime): dataSpending});
        } else {
          dataSpending.add(spending.id!);
          data.addAll(
              {DateFormat("MM_yyyy").format(spending.dateTime): dataSpending});
          firestoreData.set(data);
        }
      }
    });
  }

  static Future deleteSpending(Spending spending) async {
    var firestoreData = FirebaseFirestore.instance
        .collection("data")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    await firestoreData.get().then((value) async {
      List<String> dataSpending = [];

      var data = value.data() as Map<String, dynamic>;
      if (data[DateFormat("MM_yyyy").format(spending.dateTime)] != null) {
        dataSpending = (data[DateFormat("MM_yyyy").format(spending.dateTime)]
                as List<dynamic>)
            .map((e) => e.toString())
            .toList();
        dataSpending.remove(spending.id);
        firestoreData.update(
            {DateFormat("MM_yyyy").format(spending.dateTime): dataSpending});
      }

      if (spending.image != null) {
        await FirebaseStorage.instance
            .ref()
            .child("spending/${spending.id}.png")
            .delete();
      }

      await FirebaseFirestore.instance
          .collection("spending")
          .doc(spending.id)
          .delete();
    });
  }

  static Future<List<Spending>> getSpendingList(List<String> list) async {
    List<Spending> spendingList = [];
    for (var element in list) {
      await FirebaseFirestore.instance
          .collection("spending")
          .doc(element)
          .get()
          .then((value) {
        Spending spending = Spending.fromFirebase(value);
        spendingList.add(spending);
      });
    }
    return spendingList;
  }

  static Future updateInfo({required myuser.User user, File? image}) async {
    if (image != null) {
      user.avatar = await uploadImage(
        folder: "avatar",
        name: "${FirebaseAuth.instance.currentUser!.uid}.png",
        image: image,
      );
    }

    updateWalletMoney(user.money);

    FirebaseFirestore.instance
        .collection("info")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(user.toMap());
  }

  static Future updateWalletMoney(int money) async {
    FirebaseFirestore.instance
        .collection("wallet")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      var data = value.data() as Map<String, dynamic>;
      data[DateFormat("MM_yyyy").format(DateTime.now())] = money;
      FirebaseFirestore.instance
          .collection("wallet")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(data);
    });
  }

  static Future addWalletMoney(int money) async {
    var data = {DateFormat("MM_yyyy").format(DateTime.now()): money};
    FirebaseFirestore.instance
        .collection("wallet")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(data);

    FirebaseFirestore.instance
        .collection("info")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"money": money});
  }

  static Future<String> uploadImage({
    required String folder,
    required String name,
    required File image,
  }) async {
    Reference upload = FirebaseStorage.instance.ref().child("$folder/$name");
    await upload.putFile(image);
    return await upload.getDownloadURL();
  }
}
