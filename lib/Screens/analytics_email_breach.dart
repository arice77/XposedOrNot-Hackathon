import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:xpose/Models/analytical_breach.dart';
import 'package:xpose/Services/api_service.dart';

class AnalyticsEmailBreach extends StatefulWidget {
  const AnalyticsEmailBreach({Key? key}) : super(key: key);
  static const routeName = '/AnalyticsEmailBreach';

  @override
  _AnalyticsEmailBreachState createState() => _AnalyticsEmailBreachState();
}

class _AnalyticsEmailBreachState extends State<AnalyticsEmailBreach> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _apiService=ApiService();
  bool isBreached = false;
  int noOfBreaches=0;
  bool isLoading =false;
  AnalyticaBreach? analyticaBreach;
   Map<String, int> yearwiseDetails = { };
  Map<String, List<Map<String, dynamic>>> dataa = { };
    List<Object> breachesDetails = [
  ];
  List<dynamic>? pastesDetials = [];
  List<List<dynamic>>?industry=[];
  SizedBox sizedBox=const SizedBox(height: 5,);

List data=[];
  bool isValidEmail(String email) {
  final RegExp regex = RegExp(
    r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$'
  );
  return regex.hasMatch(email);
}
Future<List<dynamic>?> getBreachAnalytics(String email) async {
  String url = "https://api.xposedornot.com/v1/breach-analytics?email=$email";
  
  try {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['BreachMetrics']['xposed_data'];
    } else {
      print("Error: ${json.decode(response.body)['message']}");
      return null;
    }
  } catch (e) {
    print("Error: $e");
    return null;
  }
}
Map<String, List<Map<String, dynamic>>>categorizeData(List<dynamic> data) {
  Map<String,List<Map<String, dynamic>>> categorizedData = {};
  for (var item in data) {
    for (var child in item['children']) {
      String categoryName = child['name'];
      categorizedData[categoryName] = [];
      for (var subChild in child['children']) {
        String subChildName = subChild['name'].replaceFirst('data_', '');
        subChild['name'] = subChildName;
        categorizedData[categoryName]!.add(subChild);
      }
        }
  }
  return categorizedData;
}

  Widget buildExposedDataSection() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(isBreached)
            const Text(
              'Exposed Data',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
           ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dataa.length,
              itemBuilder: (context, index) {
                final category = dataa.keys.elementAt(index);
                return ExpansionTile(
                  title: Text(category),
                  children: [
                    buildExposedDataTree(dataa[category]??[]),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExposedDataTree(List<Map<String, dynamic>> exposedData) {
    return SizedBox(height: 50*exposedData.length.toDouble(),
      child: ListView.builder(itemCount: exposedData.length,itemBuilder: (context, index) {
        return ListTile(
          title: Text(exposedData[index]['name']),
          trailing: Text(exposedData[index]['value'].toString()),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
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
                    analyticaBreach= await _apiService.dataBreachAnalyticsForEmail(_emailController.text,context);
                if(analyticaBreach!=null){
                     String? aa=analyticaBreach?.breachesSummary?.site;
                   data=aa!.split(";");
                   final res=await getBreachAnalytics(_emailController.text);
                   dataa=categorizeData(res??[]);
                   yearwiseDetails=analyticaBreach?.breachMetrics?.yearwiseDetails?.first??{};
                   breachesDetails=analyticaBreach?.exposedBreaches?.breachesDetails??[];
                    pastesDetials=analyticaBreach?.exposedPastes??[];
                   industry= analyticaBreach!.breachMetrics!.industry?.first??[];

                 
                   setState(() {
                    noOfBreaches=data.length;
                      isBreached=true;
                      isLoading=false;
                   });
                }else{
                  setState(() {
                    isLoading=false;
                  });
                }
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
                if(isLoading)const Center(child: CircularProgressIndicator(color: Colors.deepPurple,),),
                if(isBreached)
                Container(padding: const EdgeInsets.only(top: 3,left: 7,right: 7),decoration: BoxDecoration(border: Border.all(width: 3,color: Colors.deepPurple),borderRadius: BorderRadius.circular(8)),height: height*0.4,
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
                ),
                sizedBox,
                if(analyticaBreach!=null)
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                  
                  Card(color: Colors.transparent,elevation: 5,shadowColor: Colors.white,child: Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),height: 240,width: width/2.4,child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,children: [const Text("Password Strength ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  sizedBox,
                const Text("Easy To Crack",style: TextStyle(fontSize: 12,color: Colors.grey),),
                sizedBox,
                Text(analyticaBreach?.breachMetrics?.passwordsStrength?.first.easyToCrack.toString()??'',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                sizedBox,
                const Text("Plain Text",style:TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),),
                Text(analyticaBreach?.breachMetrics?.passwordsStrength?.first.plainText.toString()??'',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                sizedBox,
                const Text("Strong Hash",style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),),
                Text(analyticaBreach?.breachMetrics?.passwordsStrength?.first.strongHash.toString()??'',style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),)]),)),
               Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),height: 240,width: width/2.4,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.deepPurpleAccent,), child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.start,children: [const Text("Risk ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
               sizedBox,
                const Text("Risk Label",style: TextStyle(fontSize: 12,color: Colors.white),),
                Text(analyticaBreach?.breachMetrics!.risk?.first.riskLabel??"",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),),
                sizedBox,
                const Text("Risk Score",style: TextStyle(fontSize: 12,color: Colors.white),),
                Text(analyticaBreach?.breachMetrics!.risk?.first.riskScore.toString()??'',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),),
                  const Text("Strong Hash",style: TextStyle(
                  fontSize: 12,
                  color: Colors.transparent,
                ),),
                Text(analyticaBreach?.breachMetrics?.passwordsStrength?.first.strongHash.toString()??'',style: const TextStyle(color: Colors.transparent,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),)]),)],),
                buildExposedDataSection(),
                const SizedBox(height: 10,),
             if(isBreached)
               const SizedBox(height: 10,),
                            if(isBreached)

                               const Row(
                                 children: [
                                   Text("Exposed Breaches",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                 ],
                               ),
                                              const SizedBox(height: 10,),



                 SizedBox(height: 300,child: ListView.builder(
        itemCount: breachesDetails.length,
        itemBuilder: (context, index) {
          final BreachesDetail breach = breachesDetails[index] as BreachesDetail;
          return BreachTile(
            breach: breach,
          );
        },
      ),),
                   if(isBreached)

        ExpansionTile(title: const Text('Year-wise Details'),children: [
                  SizedBox(height: yearwiseDetails.length*15,
                   child: ListView.builder(
        itemCount: yearwiseDetails.length,
        itemBuilder: (context, index) {
          String year = yearwiseDetails.keys.elementAt(index);
          int value = yearwiseDetails[year] ?? 0;
          return ListTile(
            title: Text(year.substring(1)),
            subtitle:Text( '${value.toString()} breaches',style:const TextStyle(color: Colors.grey) ,),
          );
        },
      ),
                 ),
               ],),
if(isBreached)     ExpansionTile(title: const Text('Paste ID'),children: [
        SizedBox(height: 300,child: ListView.builder(
          itemCount: pastesDetials?.length,
          itemBuilder: (context, index) {
            final paste = pastesDetials?[index];
            return ListTile(
              title: Text('ID: ${paste?['pasteId']}'),
              subtitle: Text('Exposed date: ${paste?['xposed_date']}'),
              trailing: Text('Records: ${paste?['xposed_records']}'),
            );
          },
        ),),
      ],),
      if(isBreached)
      ExpansionTile(title: const Text('Industries'),children: [
        SizedBox(height: 300,child: ListView.builder(
          itemCount: industry?.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Industry: ${industry?[index][0]}'),
              trailing: Text('Records: ${industry?[index][1]}'),
            );
          },
        ),),
      ],),
              ],
            ),
          ),
        ),
      ),);
      
  }
}

class BreachTile extends StatefulWidget {
  final BreachesDetail breach;

  const BreachTile({Key? key, required this.breach}) : super(key: key);

  @override
  _BreachTileState createState() => _BreachTileState();
}


class _BreachTileState extends State<BreachTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        
        title: Text(
          widget.breach.breach??'',
          style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
        ),
        onExpansionChanged: (isExpanded) {
          setState(() {
            _isExpanded = isExpanded;
          });
        },
        initiallyExpanded: _isExpanded,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Details:',
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.breach.details??'',
                  style: const TextStyle(color: Colors.purple),
                ),
                const SizedBox(height: 8),
                Text(
                  'Domain: ${widget.breach.domain??''}',
                  style: const TextStyle(color: Colors.purple),
                ),
                const SizedBox(height: 8),
                Text(
                  'Industry: ${widget.breach.industry??''}',
                  style: const TextStyle(color: Colors.purple),
                ),
                // Add more details here as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}