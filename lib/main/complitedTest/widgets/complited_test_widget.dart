import 'package:core/color_constants.dart';
import 'package:flutter/material.dart';

class ComplitedTestWidget extends StatelessWidget {
  double result;
  ComplitedTestWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Image.asset('assets/images/successfully.png'),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Text(
                'Тест завершен!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 100),
            Text(
                'Ваш результат: ${double.parse(result.toString()).toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                )),
            // const SizedBox(height: 50),
            Expanded(child: Container()),
            Container(
              margin: const EdgeInsets.only(top: 50, bottom: 50),
              height: 40,
              width: 200,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(ColorConstants.darkBlue)),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Вернуться на главную'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
