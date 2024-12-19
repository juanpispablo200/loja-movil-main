import 'package:flutter/material.dart';
import 'package:loja_movil/src/presentation/MenuPages/data.dart';

class FrequentQuestions extends StatefulWidget {
  const FrequentQuestions({super.key});

  static const routeName = '/frequent_questions';
  static const String name = 'frequent-questions-screen';

  @override
  State<FrequentQuestions> createState() => _FrequentQuestions();
}

class _FrequentQuestions extends State<FrequentQuestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Preguntas Frecuentes',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          backgroundColor: const Color(0XFFFFFFFF),
          elevation: 0,
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Image.asset(
                'assets/images/escudo.png',
                height: 40.0,
              ),
            ),
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: SizedBox(
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 40.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Image.asset('assets/images/loja-en-linea-blue.png'),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: frequentQuestions.entries.map((entry) {
                          String topic = entry.key;
                          List<Map<String, String>> questions = entry.value;
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  topic,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(height: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: questions.map((qna) {
                                    return Card(
                                        color: const Color.fromARGB(
                                            255, 245, 245, 245),
                                        child: ExpansionTile(
                                          title: Text(qna['question']!),
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(0),
                                                  topRight: Radius.circular(0),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                                color: Color.fromARGB(
                                                    31, 154, 154, 154),
                                              ),
                                              padding: const EdgeInsets.all(20),
                                              width: double.infinity,
                                              child: Text(qna['answer']!),
                                            )
                                          ],
                                        ));
                                  }).toList(),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ))));
  }
}
