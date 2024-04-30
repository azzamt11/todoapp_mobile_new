import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todoapp_mobile/feature/data/model/project.dart';
import 'package:todoapp_mobile/feature/presentation/widget/text_widget.dart';

class ItemCard extends StatefulWidget {
  final Project data;
  final Function(Size size) onTapFunction;
  final int? coverRatio;
  const ItemCard({
    Key? key,
    required this.data,
    required this.onTapFunction,
    this.coverRatio,
  }) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isTapped= false;
  bool isLoading= false;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 150,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 8,
                color: Colors.black12,
                offset: Offset(0, 3),
              )
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
              width: 150,
              child: Center(
                child: Icon(Icons.folder, size: 50, color: Colors.orange),
              )
            ),
            TextWidget(text: widget.data.title?? "Untitles", type: 2),
            TextWidget(text: widget.data.createdAt.toString(), type: 3)
          ],
        )
    );
  }
}