import 'package:inovola/model/types.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'course.g.dart';

@JsonSerializable()
class Course {
  Course(
    this.title,
    this.img,
    this.interest,
    this.date,
    this.address,
    this.trainerImg,
    this.reservTypes,
    this.trainerInfo,
    this.occasionDetail,
    this.trainerName
  );

  String? title;
  List<String>? img;
  String? interest;
  DateTime? date;
  String? address;
  String? trainerName;
  String? trainerImg;
  String? trainerInfo;
  String? occasionDetail;
  List<Types>? reservTypes;
  
  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
