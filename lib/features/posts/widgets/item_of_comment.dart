import 'package:flutter/material.dart';


itemOfComment(
    {required context,
    required String image,
    required String title,
    required String message}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
    child: Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(image),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  message,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
