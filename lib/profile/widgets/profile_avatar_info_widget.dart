import 'package:flutter/material.dart';

class ProfileAvatarInfoWidget extends StatelessWidget {
  ProfileAvatarInfoWidget({super.key, required this.fio, required this.email});

  var fio = '';
  var email = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBGwlAahaapmmJ7Riv_L_ZujOcfWSUJnm71g&usqp=CAU'),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  fio,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(email),
            ],
          ),
        )
      ],
    );
  }
}