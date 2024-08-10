import 'package:flutter/material.dart';

class exerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  void Function(bool?)? onCheckBoxChanged;
  final VoidCallback onDelete;



   exerciseTile({
    super.key,
    required this.exerciseName,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.isCompleted,
    required this.onCheckBoxChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListTile(
        title: Text(
          exerciseName,
           style: TextStyle(
                      color: Color.fromRGBO(109, 0, 82, 1),
                      fontWeight: FontWeight.w500),
        ),
        subtitle: Row(
          children: [
            //weights
            Chip(
              label: Text(
                "${weight}kg",
                style: TextStyle(
                      color: Color.fromRGBO(109, 0, 82, 1),
                      fontWeight: FontWeight.w500),
              ),
            ),
            //reps
            Chip(
              label: Text(
                "$reps reps",
                style: TextStyle(
                      color: Color.fromRGBO(109, 0, 82, 1),
                      fontWeight: FontWeight.w500),
              ),
            ),
            //sets
            Chip(
              label: Text(
                "$sets sets",
                style: TextStyle(
                      color: Color.fromRGBO(109, 0, 82, 1),
                      fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
         trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: isCompleted,
              onChanged: onCheckBoxChanged,
              activeColor: Color.fromRGBO(109, 0, 82, 1), // Change the color when checked
              checkColor: Colors.white, // Change the color of the check mark
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Color.fromRGBO(109, 0, 82, 1)),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
