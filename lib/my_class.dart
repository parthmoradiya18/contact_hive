import 'package:hive/hive.dart';
part 'my_class.g.dart';
@HiveType(typeId: 0)
class my_class extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  String contact;
  @HiveField(2)
  String email;
  @HiveField(3)
  String pass;
  @HiveField(4)
  String gender;
  @HiveField(5)
  String skill;
  // @HiveField(6)
  // String city;
  @HiveField(7)
  String image;

  my_class(this.name, this.contact, this.email, this.pass, this.gender,
      this.skill, this.image);

  @override
  String toString() {
    return 'my_class{name: $name, contact: $contact, email: $email, pass: $pass, gender: $gender, skill: $skill, image: $image}';
  }

// my_class(this.name, this.contact, this.email, this.pass, this.gender,
  //     this.skill, this.city, this.image);
  //
  // @override
  // String toString() {
  //   return 'my_class{name: $name, contact: $contact, email: $email, pass: $pass, gender: $gender, skill: $skill, city: $city, image: $image}';
  // }



}