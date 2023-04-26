import 'package:flutter/material.dart';

class ProfileInfoWidget extends StatelessWidget {
  ProfileInfoWidget({super.key, required this.fio, required this.email});

  var fio = '';
  var email = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Личные данные',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ФИО',
                style: TextStyle(color: Colors.black38),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(fio),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'E-mail',
                style: TextStyle(color: Colors.black38),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(email),
              ),
            ],
          ),
        )
      ],
    );
  }
}