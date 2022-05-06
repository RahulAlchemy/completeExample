import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerWidget extends StatelessWidget{
  final String? name;
  final String? score;
  final String? id;
  final VoidCallback onTap;
   PlayerWidget({this.name, this.score, this.id,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RawMaterialButton(
          child: Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(name??"TBA",
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 20),
                Text(score??"--",
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: onTap,
          fillColor:const Color(0xFF1a1a1a) ,

        ),
        const SizedBox(height: 5.0,)
      ],
    );
  }

}