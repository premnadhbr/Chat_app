import 'package:chat_app/app/controller/chat/bloc/chat_bloc.dart';
import 'package:chat_app/app/utils/components/bottomsheet.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageTextField extends StatefulWidget {
  final String currentId;
  final String friendId;

  MessageTextField(this.currentId, this.friendId);

  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is BottomSheetSuccessState) {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => bottomSheet(context),
          );
        }
      },
      builder: (context, state) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsetsDirectional.all(8),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    labelText: "Type your Message",
                    fillColor: Colors.grey[100],
                    filled: true,
                    prefixIcon: IconButton(
                      onPressed: () {
                        BlocProvider.of<ChatBloc>(context)
                            .add(BottomSheetEvent());
                      },
                      icon: const Icon(EneftyIcons.add_circle_bold),
                    ),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0),
                        gapPadding: 10,
                        borderRadius: BorderRadius.circular(25))),
              )),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () async {
                  String message = controller.text;
                  controller.clear();
                  if (message.isNotEmpty) {
                    BlocProvider.of<ChatBloc>(context).add(ChatShareEvent(
                        currentId: widget.currentId,
                        friendId: widget.friendId,
                        message: message));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
