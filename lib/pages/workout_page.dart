import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/components/exercise_tile.dart';
import 'package:tracker/data/workout_data.dart';

class workoutPage extends StatefulWidget {
  final String workoutName;
  const workoutPage({super.key, required this.workoutName});

  @override
  State<workoutPage> createState() => _workoutPageState();
}

class _workoutPageState extends State<workoutPage> {

  //check box was tapped
  void onCheckboxChanged(String workoutName,String exerciseName){

    Provider.of <workoutData>(context, listen: false).checkOffExercise(workoutName, exerciseName);

  }
  // delete exercise
  void onDeleteExercise(String workoutName, String exerciseName) {
    Provider.of<workoutData>(context, listen: false).deleteExercise(workoutName, exerciseName);
  } 

  //text controllers
  final exerciseNameController = TextEditingController();
  final weightController = TextEditingController();
  final repsController = TextEditingController();
  final setsController = TextEditingController();


  //create new exercise
  void createNewExercise() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:  Colors.grey[100],
        title: Text('Add a new exercise', style: TextStyle(color: Color.fromRGBO(109, 0, 82, 1), fontWeight: FontWeight.w500),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //exercise name
            TextField(
              controller: exerciseNameController,
            ),
            //weight
            TextField(
              controller: weightController,
            ),
            //reps
            TextField(
              controller: repsController,
            ),
            //sets
            TextField(
              controller: setsController,
            )
          ],
        ),

        actions: [MaterialButton(
            onPressed: save,
            child: const Text(
              "save",
              style: TextStyle(
                  color: Color.fromRGBO(109, 0, 82, 1),
                  fontWeight: FontWeight.w500),
            ),
          ),

          //cancel button
          MaterialButton(
            onPressed: cancel,
            child: const Text(
              "cancel",
              style: TextStyle(
                  color: Color.fromRGBO(109, 0, 82, 1),
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
  
  // save exercise
  void save() {
    //to get exercise name from the controller
    String newExerciseName = exerciseNameController.text;
    String weight = weightController.text;
    String reps = repsController.text;
    String sets = setsController.text;
    //add exercise to workout
    Provider.of<workoutData>(context, listen: false).addExercise(widget.workoutName, newExerciseName, weight, reps, sets);

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
    exerciseNameController.clear();
    weightController.clear();
    repsController.clear();
    setsController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<workoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(109, 0, 82, 1),
          title: Text(widget.workoutName, style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w900),),
          toolbarHeight: 100.0,
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor:  Color.fromRGBO(109, 0, 82, 1),
          onPressed: createNewExercise,
          child: Icon(Icons.add, color: Colors.white),
        ) ,
        
        body: Padding(
          padding: const EdgeInsets.only(top:16.0),
          child: ListView.builder(
              itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
              itemBuilder: (context, index){
              final exercise = value
                  .getRelevantWorkout(widget.workoutName)
                  .exercises[index];

              return exerciseTile(
                exerciseName: exercise.name,
                weight: exercise.weight,
                reps: exercise.reps,
                sets: exercise.sets,
                isCompleted: exercise.isCompleted,
                onCheckBoxChanged: (val) => onCheckboxChanged(
                  widget.workoutName,
                  exercise.name,
                ),
                onDelete: () => onDeleteExercise(
                  widget.workoutName,
                  exercise.name,
                ),
              );
            },
                ),
        ),
      ),
    );
  }
}
