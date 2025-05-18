import 'package:authentication_ptcl/comman/custom_appbart.dart';
import 'package:authentication_ptcl/pages/dashboard/message/chat/chat_controller.dart';
import 'package:authentication_ptcl/pages/dashboard/message/chat/widgets/chat_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';


/// A view that displays the chat interface.
class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: CustomAppbar(),
        body:
         SafeArea(
            child: Column(
              children: [
                
                     Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: controller.scrollController,
                        itemCount: 10,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        itemBuilder: (context, index) {
                        
                    
                          return 
                              yourMsg("Your");
                              //responseMsg("Response");
                        },
                      ),
                    ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right:20,
                    bottom: 12,
                  ),
                  child:TextField(
                   
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                        
                        },
                      ),
                    ),

                  )
                ),
              ],
            ),
          )
        
      ),
    );
  }
}
