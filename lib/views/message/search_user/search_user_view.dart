// import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
// import 'package:get/get.dart';
// import 'package:vibemate/common/app_colors.dart';
// import 'package:vibemate/common/app_fonts.dart';
// import 'package:vibemate/common/common_ui.dart';
// import 'package:vibemate/common/custom_app_bar.dart';
// import 'package:vibemate/common/custom_textfield.dart';
// import 'package:vibemate/common/font_sizes.dart';
// import 'package:vibemate/global.dart';
// import 'package:vibemate/lang/strings.dart';
// import 'package:vibemate/pages/dashboard/message/search_user/search_user_controller.dart';
// import 'package:vibemate/pages/dashboard/message/widgets/messages_widgets.dart';
// import 'package:vibemate/pages/dashboard/widgets/dashboard_widgets.dart';

// /// A view that allows users to search_user for messages.
// class SearchUserView extends GetView<SearchUserController> {
//   const SearchUserView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       behavior: HitTestBehavior.translucent,
//       onTap: () {
//         Global.hideKeyboard();
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.colorBackground,
//         appBar: CustomAppBar(title: Strings.textSearch.tr, shadow: false),
//         body: Column(
//           children: [
//             CustomTextField(
//               prefixIcon: Icons.search,
//               topPadding: 20,
//               inputFormatters: [NoLeadingSpaceFormatter()],
//               hintText: Strings.textSearch.tr,
//               onChanged: (value) => controller.searchQuery.value = value,
//             ),
//             Expanded(
//               child: Obx(() {
//                 if (controller.filteredMessages.isEmpty) {
//                   return Center(
//                     child: NeumorphicText(
//                       Strings.textNoMessagesFound.tr,
//                       style: CommonUI.customNeuMorphismStyle(
//                         color: AppColors.colorBlack,
//                         shadowDarkColor: Colors.black26,
//                       ),
//                       textStyle: NeumorphicTextStyle(
//                         fontSize: AppFontSizes.font18,
//                         fontFamily: AppFonts.fontSemiBold,
//                       ),
//                     ),
//                   );
//                 }
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   padding: EdgeInsets.only(
//                     top: 20,
//                     bottom: Global.appBottomSpace,
//                   ),
//                   itemCount: controller.filteredMessages.length,
//                   itemBuilder: (context, index) {
//                     return messageItem(
//                       onPressed: () {},
//                       name: controller.filteredMessages[index].name,
//                       // Add any other properties you want to display
//                     ); // Reuse the existing `messageItem` widget
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
