List<String> names = ['Push Ups', 'Abdominal Crunches', 'Sit-Ups', 'Arm Raises', 'Leg Raises', 'Row Pushup', 'Biceps Curl', 'Ball Plank', 'Yoga', 'Seated Cable Row', 'Inclined Barbel Press', 'Flat Barbel Press', 'Shoulder Press', 'Decline Crunches', 'Break Time' ];
List<int> durations = [10, 10, 10, 20, 10, 20, 10, 20,
                        10, 20, 10, 20, 20, 10, 10];

class Workout{
  String name;
  int id;
  int duration; //in seconds

  Workout(int i){
    id = i;
    name = names[i-1];
    duration = durations[i-1];
  }

}