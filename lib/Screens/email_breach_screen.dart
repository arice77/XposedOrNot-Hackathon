import 'package:flutter/material.dart';
import 'package:xpose/Services/api_service.dart';

class EmailBreachScreen extends StatefulWidget {
  const EmailBreachScreen({Key? key}) : super(key: key);
  static const routeName = '/emailBreachScreen';

  @override
  _EmailBreachScreenState createState() => _EmailBreachScreenState();
}

class _EmailBreachScreenState extends State<EmailBreachScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _apiService=ApiService();
  bool isBreached = false;
  int noOfBreaches=0;
  bool isLoading =false;
  List<dynamic> data = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  bool isValidEmail(String email) {
  final RegExp regex = RegExp(
    r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$'
  );
  return regex.hasMatch(email);
}


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      
      appBar: AppBar(iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Email Breach Screen',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(cursorColor: Colors.deepPurple,
                  controller: _emailController,
                  decoration: const InputDecoration(focusColor: Colors.deepPurple,suffixIcon: Icon(Icons.email,),
                    labelText: 'Enter your email',
                    labelStyle: TextStyle(color: Color(0xFF2C3E50)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                  ),
                  
                  validator: (value) {
                    if (value == null ||!isValidEmail(_emailController.text)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: const Color(0xFFFFFFFF),
                  ),
                  onPressed: ()async {
                    if (_formKey.currentState!.validate()) {
                        setState(() {
                     isLoading=true;
                   });
                   var a= await _apiService.checkEmailAddressDataBreaches(_emailController.text);
                   data=a??[];
                 
                   setState(() {
                    noOfBreaches=data.length;
                      isBreached=true;
                      isLoading=false;
                   });
                       FocusScope.of(context).unfocus();


                   
                    }
                  },
                  child: const Text('Submit'),
                ),
                const SizedBox(height: 10,),
                if(isBreached)
                Row(
                  
                  children: [
                    Text('Found $noOfBreaches Breaches :', style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),),
                  ],
                ),
                const SizedBox(height: 10,),
                if(isLoading)Center(child: CircularProgressIndicator(color: Colors.deepPurple,),),
                if(isBreached)
                Container(height: height*0.7,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        decoration: BoxDecoration(border: Border.all(color: Colors.deepPurple),
                         
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            data[index],
                            style: const TextStyle(color: Colors.black,fontSize: 15),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}