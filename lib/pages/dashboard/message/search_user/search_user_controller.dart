// import 'package:get/get.dart';
// import 'package:vibemate/model/friend_model.dart';
// import 'package:vibemate/model/message_model.dart';
// import 'package:vibemate/model/request_model.dart';
// import 'package:vibemate/pages/dashboard/message/message_controller.dart';

// /// SearchUserController is a GetX controller that manages the state of the search functionality
// class SearchUserController extends GetxController {
//   var searchQuery = ''.obs;
//   var filteredMessages = <FriendModel>[].obs;
//   var messageController = Get.find<MessageController>();

//   @override
//   void onInit() {
//     super.onInit();
//     filteredMessages.value = messageController.allFriends.value;
//     ever(searchQuery, (_) {
//       if (searchQuery.value.isEmpty) {
//         filteredMessages.value = messageController.allFriends;
//       } else {
//         filteredMessages.value =
//             messageController.allFriends
//                 .where(
//                   (message) => message.name.toLowerCase().contains(
//                     searchQuery.value.toLowerCase(),
//                   ),
//                 )
//                 .toList();
//       }
//     });
//   }
// }
