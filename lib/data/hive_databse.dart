import 'package:hive_flutter/adapters.dart';
import 'package:tracker/datetime/date_time.dart';
import 'package:tracker/models/exercise.dart';
import 'package:tracker/models/workout.dart';

class HiveDatabase{

   // references our hive box
   final _myBox = Hive.box("mybox");

   //checck if there is already data stored, if not, record the start date
   bool previousDataExists() {
    if (_myBox.isEmpty) {
      print("previous data does not exist");
      _myBox.put("START DATE", todaysDateYYYYMMDD());
      return false;
    } else {
      print("previous data exist");
      return true;
    }
  }
   
   
   
   //return the start date as yyyymmdd
   String getStartDate() {
    return _myBox.get("START_DATE")  ?? todaysDateYYYYMMDD();
  }
   
   //write data
  void saveToDatabase(List<workout> workouts) {
    //convert workout objects into list of stings so that we can save them in hive
    final workoutList = convertObjectToWorkoutList(workouts);
    final exerciseList = convertObjectToExerciseList(workouts);

    /* 
        check weather if any exercise have been done 
         we will put 0 or 1 for each yyyymmmdd date
  
    */

    if (exerciseCompleted(workouts)) {
      _myBox.put("COMPLETION_STATUS_${todaysDateYYYYMMDD()}", 1);
    } else {
      _myBox.put("COMPLETION_STATUS_${todaysDateYYYYMMDD()}", 0);
    }
    //save to the hive
    _myBox.put("WORKOUTS", workoutList);
    _myBox.put("EXERCISES", exerciseList);


  }
   
   
   //read data , and return a list of workouts
  List<workout> readFromDatabase() {
    List<workout> mySavedWorkouts = [];

    List<String> workoutNames = _myBox.get("WORKOUTS");
    final exerciseDetails = _myBox.get("EXERCISES");

    //create workout objects
    for (int i = 0; i < workoutNames.length; i++) {
      // for each workout there or or many exercises
      List<exercise> exercisesInEachWorkout = [];

      for (int j = 0; j < exerciseDetails[i].length; j++) {
        // so add each exercise into a list
        exercisesInEachWorkout.add(
          exercise(
            name: exerciseDetails[i][j][0],
            weight: exerciseDetails[i][j][1],
            reps: exerciseDetails[i][j][2],
            sets: exerciseDetails[i][j][3],
            isCompleted: exerciseDetails[i][j][4] == "true" ? true : false,
          ),
        );
      }
      //create individual workout
      workout workouts =
          workout(name: workoutNames[i], exercises: exercisesInEachWorkout);

      //add individual workout to overoll list
      mySavedWorkouts.add(workouts);
    }
    return mySavedWorkouts;
  }


  //checks if any exercise have been done probbly yes or no
   bool exerciseCompleted(List<workout> workouts) {
    //going through each workout
    for (var workout in workouts) {
      //goinh  through each exercise in workout
      for (var exercise in workout.exercises) {
        if (exercise.isCompleted) {
          return true;
        }
      }
    }
    return false;
   }
   
  //return completion status if a given date yyyymmdd
  int getCompletionStatus(String yyyymmdd){

    // returns 0 or 1 , if null return 0
    int completionStatus = _myBox.get("COMPLETION_STATUS_$yyyymmdd") ?? 0;
    return completionStatus;
  }
  
}

   
   
   

//converts workout objects into a list
List<String> convertObjectToWorkoutList(List<workout> workouts){
  List<String> workoutList = [
     //ex: [upperbody , lowerbody]
  ];

  for (int i=0; i<workouts.length;i++){
    //in eachb workout, add the name, followed by lists of exercises
    workoutList.add(workouts[i].name,);
  }

  return workoutList;
}

//converts the exercises in a workout object into a list of strings
List<List<List<String>>> convertObjectToExerciseList(List<workout> workouts) {
  List<List<List<String>>> exerciseList = [
    /* 
      [
      upper body
      [[biceps,2kg,10 reps,3sets] , [triceps,3kg,10reps,3sets]],
      
      ]
      */
  ];
// go theough each workout
  for (int i = 0; i < workouts.length; i++) {
    // grt exercises from eaach workout
    List<exercise> exercisesInWorkout = workouts[i].exercises;

    List<List<String>> individualWorkout = [
      //upper body
      //[[biceps,2kg,10 reps,3sets] , [triceps,3kg,10reps,3sets]],
    ];
    // go through each exercse in exerciselist
    for (int j = 0; j < exercisesInWorkout.length; j++) {
      List<String> individualExercise = [
        //[biceps,2kg,10 reps,3sets]
      ];
      individualExercise.addAll(
        [
          exercisesInWorkout[j].name,
          exercisesInWorkout[j].weight,
          exercisesInWorkout[j].reps,
          exercisesInWorkout[j].sets,
          exercisesInWorkout[j].isCompleted.toString(),
        ],
      );
      individualWorkout.add(individualExercise);
    }
    exerciseList.add(individualWorkout);
  }
  return exerciseList;
}
