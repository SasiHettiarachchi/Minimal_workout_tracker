import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:tracker/components/heat_map.dart';
import 'package:tracker/data/workout_data.dart';
import 'package:tracker/pages/workout_page.dart';

class homePage extends StatefulWidget {
  
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

 @override
 void initState(){
  super.initState();

  SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<workoutData>(context, listen: false).initializeWorKoutList();
    });
 }




  //text controller
  final newWorkoutNameController = TextEditingController();

 //create a new workout
  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:  Colors.grey[100],
        title: Text("Create new workout" , style: TextStyle(color: Color.fromRGBO(109, 0, 82, 1), fontWeight: FontWeight.w500),),
        content: TextField(
          controller: newWorkoutNameController,
        ),
        actions: [
          //save button
          MaterialButton(
            onPressed: save,
            child: const Text("save", style: TextStyle(color: Color.fromRGBO(109, 0, 82, 1), fontWeight: FontWeight.w500),),
          ),

          //cancel button
          MaterialButton(
            onPressed: cancel,
            child: const Text("cancel" , style: TextStyle(color: Color.fromRGBO(109, 0, 82, 1), fontWeight: FontWeight.w500),),
          ),
        ],
      ),
    );
  }
  //go to workout page
  void goToWorkoutPage(String workoutName){
    Navigator.push(context, MaterialPageRoute(builder: (context) => workoutPage(workoutName: workoutName,),));
  }
  // save workout
  void save() {
    //to get workout name from the controller
    String newWorkoutName = newWorkoutNameController.text;

    //add workout to workoutdata list
    Provider.of<workoutData>(context, listen: false).addWorkout(newWorkoutName);

    //pop dialog
    Navigator.pop(context);
    clear();
  }

  //cancel
  void cancel() {

     //pop dialog
    Navigator.pop(context);
    clear();
  }

  //clear controllers
  void clear(){
    newWorkoutNameController.clear();
  }

  // delete workout
  void deleteWorkout(String workoutName) {
    Provider.of<workoutData>(context, listen: false).deleteWorkout(workoutName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<workoutData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
            child: Text(
              'WORKOUT TRACKER',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            ),
          ),
          backgroundColor: Color.fromRGBO(109, 0, 82, 1), // color of app bar
          toolbarHeight: 100.0, // app bar height
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor:  Color.fromRGBO(109, 0, 82, 1),
          onPressed: createNewWorkout,
          child: Icon(Icons.add, color: Colors.white),
        ),

        body: ListView(
          children: [
            //heat map
            MyHeatMap(
                datasets: value.heatMapDataSet,
                startDateYYYYMMDD: value.getStartDate()),

            //workout list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getWorkoutList().length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  value.getWorkoutList()[index].name,
                  style: TextStyle(
                      color: Color.fromRGBO(109, 0, 82, 1),
                      fontWeight: FontWeight.w500),
                ),
                trailing:  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Color.fromRGBO(109, 0, 82, 1),
                      ),
                      onPressed: () => deleteWorkout(value.getWorkoutList()[index].name),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromRGBO(109, 0, 82, 1),
                      ),
                      onPressed: () =>
                          goToWorkoutPage(value.getWorkoutList()[index].name),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
