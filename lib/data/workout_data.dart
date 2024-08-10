// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:tracker/data/hive_databse.dart';
import 'package:tracker/datetime/date_time.dart';
import 'package:tracker/models/exercise.dart';
import 'package:tracker/models/workout.dart';

class workoutData extends ChangeNotifier {
  final db = HiveDatabase();

  List<workout> workoutList = [
    //default workout
    workout(
      name: "Upper body strength",
      exercises: [
        exercise(name: "Bicep curls", weight: "2", reps: "10", sets: "3"),
      ],
    ),
    workout(
      name: "lower body strength",
      exercises: [
        exercise(name: "squads", weight: "2", reps: "10", sets: "3"),
      ],
    ),
    workout(
      name: "total body HIIT",
      exercises: [
        exercise(name: "bicycles", weight: "no weights", reps: "10", sets: "3"),
      ],
    ),
  ];
  
  
  //if there are workouts already in database, then get that workoutlist,
  void initializeWorKoutList() {
    if (db.previousDataExists()) {
      workoutList = db.readFromDatabase();
    }
    //otherwise use default workoutlist
    else {
      db.saveToDatabase(workoutList);
    }

    // load heat map
    loadHeatMap();
  }

  //list of workouts

  List<workout> getWorkoutList() {
    return workoutList;
  }

  //getting no of execise in a workout
  int numberOfExercisesInWorkout(String workoutName) {
    workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  //add a workout
  void addWorkout(String name) {
    //add a new workout with a blank list of exercises
    workoutList.add(workout(name: name, exercises: []));
    notifyListeners();
    // save to database
    db.saveToDatabase(workoutList);
  }
   
   // delete a workout
  void deleteWorkout(String workoutName) {
    // find and remove the relevant workout
    workoutList.removeWhere((workout) => workout.name == workoutName);
    notifyListeners();
    // save to database
    db.saveToDatabase(workoutList);
  }
  
  //add an exercise to the workout
  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    //find the relevant workout
    workout relevantWorkout = getRelevantWorkout(workoutName);

    relevantWorkout.exercises.add(
      exercise(name: exerciseName, weight: weight, reps: reps, sets: sets),
    );
    notifyListeners();
    // save to database
    db.saveToDatabase(workoutList);
  }

  //check of exercises
  void checkOffExercise(String workoutName, String exerciseName) {
    //find out the relevant workout and exercise in that workout
    exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);


    //check off boolean to show user completed that exercise
    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    print('tapped');
    
    notifyListeners();

    // save to database
    db.saveToDatabase(workoutList);

    //load heat map
    loadHeatMap();
  }
  //additionaly added
  // delete an exercise from a workout
  void deleteExercise(String workoutName, String exerciseName) {
    // find the relevant workout
    workout relevantWorkout = getRelevantWorkout(workoutName);

    // find and remove the relevant exercise
    relevantWorkout.exercises.removeWhere((exercise) => exercise.name == exerciseName);
    notifyListeners();
    // save to database
    db.saveToDatabase(workoutList);
  }

  // return relevant workout object, givrn a workout name
  workout getRelevantWorkout(String workoutName) {
    return workoutList.firstWhere((workout) => workout.name == workoutName);
  }

  // return relevant exercise object, givrn a exercise name
  exercise getRelevantExercise(String workoutName, String exerciseName) {
    //find relevant workout first and then the exercise
    workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);
    return relevantWorkout.exercises.firstWhere((exercise) => exercise.name == exerciseName);
  }

  //get start date
  String getStartDate(){
    return db.getStartDate();
  }

  /*
  heat map
  */
  Map<DateTime, int> heatMapDataSet = {};

  void loadHeatMap(){
    DateTime? startDate = createDateTimeObject(getStartDate());

    if (startDate == null) {
      print('Invalid start date');
      return; // or handle the error as appropriate
    }

    //count no:of dates to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    //go from start date to today date, and add each completion status to the data set
   //"COMPLETION_STATUS_yyyymmdd" wii be the key in the database

   for (int i =0; i< daysInBetween + 1; i++){
    String yyyymmdd = 
          convertDateTimeToYYYYMMDD(startDate.add(Duration(days: i)));

    // completion status 0 or 1
    int completionStatus = db.getCompletionStatus(yyyymmdd);

    //year
     int year = startDate.add(Duration(days: i)).year;

    //month
      int month = startDate.add(Duration(days: i)).month;

    //day
      int day = startDate.add(Duration(days: i)).day;

    final percentForEachDay = <DateTime, int>{
      DateTime(year, month, day) : completionStatus
    };

    // add to the heat map data set
    heatMapDataSet.addEntries(percentForEachDay.entries);



   } 
  }




}


