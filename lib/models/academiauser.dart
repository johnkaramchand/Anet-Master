class SaiyanAttendanceData {

  List < SaiynaAttendance > saiyanattendance;

  SaiyanAttendanceData({
    this.saiyanattendance
  });
  
  SaiyanAttendanceData.fromJson(List < dynamic > json) {
    saiyanattendance = new List < SaiynaAttendance > ();
    for (var v in json) {
      saiyanattendance.add(SaiynaAttendance.fromJson(v));
    }
    print(saiyanattendance);
  }

  Map < String, dynamic > toJson() {
    final Map < String, dynamic > data = new Map < String, dynamic > ();
    if (this.saiyanattendance != null) {
      data['events'] = this.saiyanattendance.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SaiynaAttendance {

      String  courseName;
     String   courseCode;
      double  attendancePercentage;
        
 



  SaiynaAttendance({
    this.courseName,
    this.courseCode,
    this.attendancePercentage
  });

  SaiynaAttendance.fromJson(Map < String, dynamic > json) {
    courseName = json['courseName'];
    courseCode = json['courseCode'];
    attendancePercentage = json['attendancePercentage'];
    
  }

  Map < String, dynamic > toJson() {
    final Map < String, dynamic > data = new Map < String, dynamic > ();
    data['courseCode'] = this.courseCode;
    data['courseName'] = this.courseName;
    data['attendancePercentage'] = this.attendancePercentage;
    
    
    return data;
  }
}
/*
List<Event> events = [
  Event(
  ),
];
*/