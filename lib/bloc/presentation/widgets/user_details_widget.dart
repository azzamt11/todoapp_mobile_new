import 'package:code/bloc/data/model/user_details.dart';
import 'package:flutter/material.dart';

class UserDetailsWidget extends StatelessWidget {
  final UserDetails userDetails;

  const UserDetailsWidget({Key? key, required this.userDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: Image.network(
            "https://mcdmobileappdev.blob.core.windows.net/img/campaigns/easter2023/00_Teaser_Countdown/TeaserCountdown.webp",
            height: 500,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 16.0,),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Name: ${userDetails.firstName ?? ""}"),
            Text("email: ${userDetails.email ?? ""}"),
          ],
        )
      ],
    );
  }
}
