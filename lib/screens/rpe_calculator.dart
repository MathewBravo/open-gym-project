import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:open_gym_project/data/rpe_data.dart';
import 'package:open_gym_project/models/rpe.dart';

class RPECalculator extends StatefulWidget {
  static const route = '/rpeCalculator';

  const RPECalculator({Key? key}) : super(key: key);

  @override
  State<RPECalculator> createState() => _RPECalculatorState();
}

class _RPECalculatorState extends State<RPECalculator> {
  bool calculated = false;
  int reps = 10;
  late TextEditingController _weightController;
  late int rpe;
  List<RPE>? matchedValues;

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController();
  }

  void calcRPE() {
    if (_weightController.text.isNotEmpty) {
      setState(() {
        matchedValues =
            rpeData.where((element) => element.reps == reps).toList();
      });
      print(matchedValues?.length);
      for (var element in matchedValues!) {
        print("${element.percentModifier} ${element.effort}");
      }
    }
  }

  Table tableCreator() {
    if(matchedValues != null){
      print("okay");
    }
    print("called");
    return Table(
      children: const [
        TableRow(children: [
          Text(""),
        ]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RPE Calculator"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            child: Center(
                child: Row(
              children: const [
                Icon(Icons.warning, color: Colors.red),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    "This is a guideline only, RPE is something that should be done entirely off of feel and is an aspect of training you should learn as you progress.",
                    style: TextStyle(overflow: TextOverflow.visible),
                  ),
                ),
              ],
            )),
          ),
          const Divider(),
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Weight"),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Reps"),
                NumberPicker(
                  axis: Axis.horizontal,
                  itemWidth: 30,
                  itemCount: 1,
                  minValue: 1,
                  maxValue: 12,
                  value: reps,
                  onChanged: (value) => setState(() {
                    reps = value;
                  }),
                )
              ],
            ),
          ),
          ElevatedButton(onPressed: calcRPE, child: const Text("Calculate")),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: tableCreator(),
          )
        ],
      ),
    );
  }
}
