import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixam_mart/features/chat/controllers/chat_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';

class MessageBubbleShimmer extends StatelessWidget {
  final bool isMe;
  const MessageBubbleShimmer({super.key, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMe ? const EdgeInsets.fromLTRB(50, 5, 10, 5) : const EdgeInsets.fromLTRB(10, 5, 50, 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Shimmer(
             period: const Duration(seconds: 2),
     
          gradient: LinearGradient(
            colors: [
              Colors.grey.withOpacity(0.1), // First color with 10% opacity
              Colors.grey.withOpacity(0.2), // Second color with 20% opacity
              Colors.grey.withOpacity(0.1), // Third color with 10% opacity
            ],
            stops: [0.1, 0.5, 0.9],  // Positions of the gradient colors
            begin: Alignment(-1.0, -0.3),
            end: Alignment(1.0, 0.3),
          ),
              enabled: Get.find<ChatController>().messageModel == null,
              child: Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(Dimensions.radiusDefault),
                    bottomLeft: isMe ? const Radius.circular(Dimensions.radiusDefault) : const Radius.circular(0),
                    bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(Dimensions.radiusDefault),
                    topRight: const Radius.circular(Dimensions.radiusDefault),
                  ),
                  color: isMe ? Theme.of(context).hintColor : Theme.of(context).disabledColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
