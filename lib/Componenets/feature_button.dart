import 'package:flutter/material.dart';

class FeatureButton extends StatelessWidget {
 final  IconData iconData;
 final String featureTtile;
 final String featureDescription;
 final String routeName;
   const FeatureButton({super.key,required this.iconData,required this.featureTtile,required this.featureDescription,required this.routeName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap:()=>Navigator.of(context).pushNamed(routeName) ,
      child: Card(elevation: 5,margin: const EdgeInsets.symmetric(vertical: 10),
          child: Container(height: 100,width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Colors.transparent),child: Row(children: [
            Container(height: 100,width: 15,decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),color: Colors.deepPurple),),
            Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),height: 100,decoration:const BoxDecoration(color:  Color.fromARGB(174, 255, 255, 255)),child: Column(
             crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Icon(iconData,color: Colors.deepPurple.shade700,),
                  Text("  $featureTtile",style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                ],
              ),
              const Divider(color: Color.fromARGB(255, 209, 208, 208),height: 6),
              Text(featureDescription,style:  TextStyle(color: Colors.deepPurple.shade900),),
            ]),))
          
          ]),),
        ),
    );
  }
}