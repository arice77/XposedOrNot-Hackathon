import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xpose/Services/api_service.dart';

class ExposedPasswordScreen extends StatefulWidget {
  const ExposedPasswordScreen({super.key});
  static const routeName = '/exposedPasswordScreen';

  @override
  State<ExposedPasswordScreen> createState() => _ExposedPasswordScreenState();
}

class _ExposedPasswordScreenState extends State<ExposedPasswordScreen> {
           final formKey = GlobalKey<FormState>();
          final TextEditingController passwordController=TextEditingController();
          final ApiService _apiService=ApiService();
            Map<String, dynamic>? passwordData;
            bool isLoading=false;


    // Determine background color based on pas    sword strength
    Color backgroundColor = Colors.black38;
      String getValueByAlphabet(Map<String,dynamic> jsonData, String alphabet) {
  // Convert the string to a map

  // Access the 'char' value
  String charValue = jsonData['SearchPassAnon']['char'];

  // Split the 'char' value based on 'D:'
  List<String> splitValues = charValue.split('$alphabet:');

  // Access the values after the alphabet
  String valuesAfterAlphabet = splitValues.length > 1 ? splitValues[1] : '';

  // Split the values after the alphabet based on ';'
  List<String> finalValues = valuesAfterAlphabet.split(';');

  // Access the value after the alphabet
  String valueAfterAlphabet = finalValues.isNotEmpty ? finalValues[0] : '';

  return valueAfterAlphabet;
}

  @override
  Widget build(BuildContext context) {
     

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple,elevation: 10,iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('XposedOrNot', style: TextStyle(color: Colors.white),),
        
      ),
      body:  SingleChildScrollView(
        child: Form(key:formKey,
          child: Column(
            children: [
               Padding(
                 padding: const EdgeInsets.all(13.0),
                 child: TextFormField(cursorColor: Colors.deepPurple,
                            controller: passwordController,
                            decoration: const InputDecoration(focusColor: Colors.deepPurple,suffixIcon: Icon(Icons.password,),
                              labelText: 'Enter your password',
                              labelStyle: TextStyle(color: Color(0xFF2C3E50)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color:Colors.deepPurple),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.deepPurple),
                              ),
                            ),
                            
                            validator: (value) {
                             if(passwordController.text.isEmpty){
                              return 'Please enter valid password';
                             }
                              return null;
                            },
                          ),
               ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: const Color(0xFFFFFFFF),
                          ),
                          onPressed: ()async {
                            setState(() {
                              isLoading=true;
                            });
                            var res;
                            if (formKey.currentState!.validate()) { 
                              res=await _apiService.checkPassword(passwordController.text);
                              print(res);

                            
                             }
                             setState(() {
                               passwordData=jsonDecode(res);
                               isLoading=false;
                             });},
                             
                          child: const Text('Submit'),
                        ),

                      if(isLoading)const CircularProgressIndicator(),

            if(passwordData!=null)             ( Padding(
              padding:  const EdgeInsets.all(16.0),
               
                   
                    child: Card(
  elevation: 4,
  color: Colors.purple,
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          '${passwordController.text}',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        const SizedBox(height: 10),
        const Text(
          'Exposed Count:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          '${passwordData?['SearchPassAnon']['count']}',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        const SizedBox(height: 10),
        const Text(
          'Alphabets Count:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          '${getValueByAlphabet(passwordData??{}, 'A')}',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        const SizedBox(height: 10),
        const Text(
          'Special Characters Count:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          '${getValueByAlphabet(passwordData??{}, 'S')}',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        const SizedBox(height: 10),
        const Text(
          'Digits Count:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          '${getValueByAlphabet(passwordData??{}, 'D')}',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        const SizedBox(height: 10),
        const Text(
          'Password Length:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          '${getValueByAlphabet(passwordData??{}, 'L')}',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        const SizedBox(height: 10),
        const Text(
          'Word List:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          '${passwordData?['SearchPassAnon']['wordlist']}',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ],
    ),
  ),
),

                        ))
                    ]),
        )));
  }
}