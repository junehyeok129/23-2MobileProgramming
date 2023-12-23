import 'package:flutter/material.dart';
import 'package:loa/loadrawer.dart';
class quiz_create extends StatefulWidget {
  @override
  quiz_createState createState() => quiz_createState();
}

class quiz_createState extends State<quiz_create> {
  List<String> numberOfQuiz = ['1','2','3','4','5','6','7','8'];
  String first_number='1';
  bool isChecked = false;
  bool isChecked2 = false;
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
      title: Center(child: Text('Quiz')),

      ),
      drawer: LoaDrawer(),
      body: Container(
        margin: EdgeInsets.fromLTRB(50, 50, 50, 50),
        decoration: BoxDecoration(
          color: Colors.amber[100],
          borderRadius: BorderRadius.circular(20)
        ),
        padding: EdgeInsets.fromLTRB(50, 50, 50, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('1. 문제 수',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Container(

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: DropdownButton(

                  isExpanded: true,
                  // borderRadius: BorderRadius.circular(10),
                  value: first_number,
                  items: numberOfQuiz
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      first_number = value.toString();
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 30,),
            Divider(thickness: 1, height: 1, color: Colors.black,),
            SizedBox(height: 30,),
            Text('2. 맞춘 문제 표시 여부'),
            SizedBox(height: 10,),
       
             Row(
               children: [
                 Text('예'),
                 Checkbox(
                     value: isChecked,
                     onChanged: (bool? newValue){
                       setState(() {
                         isChecked = newValue!;
                       });
                     },

                   activeColor: Colors.black,
                   checkColor: Colors.white,
                     ),
                 Text('아니오'),
                 Checkbox(
                   value: isChecked2,
                   onChanged: (bool? newValue){
                     setState(() {
                       isChecked2 = newValue!;
                     });
                   },

                   activeColor: Colors.black,
                   checkColor: Colors.white,
                 ),
               ],
             ),
            SizedBox(height: 30,),
            Divider(thickness: 1, height: 1, color: Colors.black,),
            SizedBox(height: 50,),
            Center(
              child: Container(

                width: 300,
                height: 80,
                child: ElevatedButton(

                    onPressed:(){
                      Navigator.pushNamed(context, '/solvequiz');
                    },
                    child: Text('CREATE',style: TextStyle(fontSize: 30,fontWeight: FontWeight.normal, color: Colors.black),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}