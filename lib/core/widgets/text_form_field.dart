import 'package:chat_app/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final IconButton? suffix;
  final bool? obscure;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  const ChatTextFormField({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.name,
    this.suffix,
    this.obscure = false,
    this.maxLength,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: TextFormField(
        controller: controller,
        maxLines: 1,
        maxLength: maxLength,
        obscureText: obscure!,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlign: maxLength == 1 ? TextAlign.center : TextAlign.left,
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(),
          focusedErrorBorder: const OutlineInputBorder(),
          focusColor: AppColors.lightThemePrimaryColor,
          suffixIconColor: AppColors.lightThemePrimaryColor,
          suffixIcon: suffix,
          counterText: "",
        ),
        inputFormatters: inputFormatters,
      ),
    );
  }
}

class MessagesTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onFieldSubmitted;
  const MessagesTextField({
    super.key,
    required this.controller,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: AppColors.whiteBackgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 15.0,
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                        child: TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Type a message...',
                      ),
                      onFieldSubmitted: onFieldSubmitted,
                    )),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.attach_file_outlined,
                        color: AppColors.shadedColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt,
                        color: AppColors.shadedColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 5.0),
          CircleAvatar(
            radius: 25.0,
            child: IconButton(
              onPressed: () {
                // if (ChatManager.chatPageManager(context).text.text != '') {
                //   ChatManager.chatPageManager(context).sendMessage(
                //       context: context,
                //       receiverId: model.id,
                //       dateTime: DateTime.now().toString(),
                //       text: ChatManager.chatPageManager(context).text.text);
                // }
                // ChatManager.chatPageManager(context).text.text = '';
              },
              icon: const Icon(
                Icons.send,
                color: AppColors.whiteBackgroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
