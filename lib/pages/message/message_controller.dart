import 'package:authentication_ptcl/comman/app_srorage.dart';
import 'package:authentication_ptcl/pages/home/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';



/// A controller that manages the state of the message list and search_user functionality.
class MessageController extends GetxController {
  var allFriends = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    //fetchFriends();
  }

  // Fetches messages from the Firestore `messages` collection.
  // void fetchFriends() async {
  //   try {
  //     final userId = AppSrorage.getUser()["uid"];
  //     final snapshot =
  //         await FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(userId)
  //             .collection('friends')
  //             .get();
  //     allFriends.value =
  //         snapshot.docs
  //             .map((doc) => FriendModel.fromJson(doc.data()))
  //             .toList();
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch friends: $e');
  //   }
  // }
}

