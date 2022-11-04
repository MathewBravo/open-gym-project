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
  int reps = 10;
  late TextEditingController _weightController;
  late int rpe;
  bool filtered = false;
  List<RPE> rpeTable = rpeData;
  double weight = 0.0;

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController();
  }

  void calcRPE() {
    if (_weightController.text.isNotEmpty) {
      setState(() {
        filtered = true;
        weight = double.parse(_weightController.text);
        //makeTable(filteredList);
      });
    }
  }

  int roundNearest5(double toBeRound){
    return 5 * (toBeRound / 5).round();
  }

  Widget rpeResults() {
    if (!filtered) {
      return const SizedBox();
    }
    else {
      var filteredList = rpeTable.where((element) => element.reps == reps);
      return SizedBox(
        width: 100,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("RPE"),
                Text("Weight"),
            ],),
            const SizedBox(height: 20,),
            for (RPE matchedReps in filteredList)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(matchedReps.effort.toStringAsFixed(1)),
                  Text(roundNearest5(matchedReps.percentModifier * weight).toString())
                ],
              )
          ],
        ),
      );
    }
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
                  onChanged: (value) =>
                      setState(() {
                        reps = value;
                      }),
                )
              ],
            ),
          ),
          ElevatedButton(onPressed: calcRPE, child: const Text("Calculate")),
          Padding(
            padding: const EdgeInsets.all(10),
            child: rpeResults(),
          )
        ],
      ),
    );
  }
}
