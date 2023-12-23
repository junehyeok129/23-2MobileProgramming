import 'package:flutter/material.dart';

// 조찬희 템플릿 작성, 최준혁 DB 및 통신 연결
class MakeQuiz extends StatefulWidget {
  @override
  _MakeQuizState createState() => _MakeQuizState();
}

class _MakeQuizState extends State<MakeQuiz> {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answer_controller= TextEditingController();
  List<String> course = [
    '모바일 프로그래밍', '멀티코어 컴퓨팅', '알고리즘', '데이터베이스 설계', '이산수학'];
  List<String> type = ['객관식','주관식'];
  List<String> correctAnswer = ['1', '2', '3'];

  String selectedCourse = '모바일 프로그래밍';
  String selectedType = '객관식';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            width: 300,
            child: Column(
              children: [
                Text('Subject', textAlign: TextAlign.start),
                DropdownButton(
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(10),
                  value: selectedCourse,
                  items: course
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCourse = value.toString();
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            width: 300,
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                Text('Question'),
                TextField(
                  controller: questionController,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            width: 300,
            child: Column(
              children: [
                Text('Answer Type', textAlign: TextAlign.start),
                DropdownButton(
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(10),
                  value: selectedType,
                  items: type
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedType = value.toString();
                    });
                  },
                ),
              ],
            ),
          ),
          if (selectedType == '객관식')
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                children: [
                  Text('객관식 문제'),
                  TextField(),
                  TextField(),
                  TextField(),
                  Container(
                    width: 300,
                    height: 50,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Add'),
                    ),
                  )
                ],
              ),
            ),

          if(selectedType=='객관식')
            Container(
              child: Column(
                children: [
                  Text('Correct Answer'),
                  DropdownButton(
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(10),
                    items: correctAnswer
                        .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                        .toList(),
                    onChanged: (value) {
                      // items 의 DropdownMenuItem 의 value 반환
                    },
                  )
                ],
              ),
            ),
          if(selectedType=='주관식')
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Column(
                children: [
                  Text('Correct Answer'),
                  TextField(
                    controller: answer_controller,
                  )
                ],
              ),
            ),

        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            // submit logic 구현
          },
          child: Text('CREATE'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is removed from the widget tree
    questionController.dispose();
    super.dispose();
  }
}


