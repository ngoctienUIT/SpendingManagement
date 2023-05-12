import '../../../models/spending.dart';

int findIndex(List<Spending> spendingList, String id) {
  for (int i = 0; i < spendingList.length; i++) {
    if (spendingList[i].id!.compareTo(id) == 0) {
      return i;
    }
  }

  return -1;
}