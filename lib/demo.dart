

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listviewwithserach/controller/demo_controller.dart';
class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final controller = Get.put(DemoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(controller.a.value.toString()),
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: ListView.builder(
            //       shrinkWrap: true,
            //       physics: const NeverScrollableScrollPhysics(),
            //       itemCount: 100,
            //       itemBuilder: (BuildContext context,index){
            //         return Text(index.toString());
            //       },
            //     ),
            //   ),
            // ),
            // Row(
            //   children: [
            //     Expanded(child: ElevatedButton(onPressed: (){},child: Text("hello"),)),
            //     Expanded(child: ElevatedButton(onPressed: (){},child: Text("hello"),)),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
