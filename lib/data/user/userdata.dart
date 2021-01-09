
import 'package:flutter/widgets.dart';
import 'package:trueconnect/utils/misc_util.dart';

class UserData{

  String id;
  String name;
  String email;
  String first_name;
  String last_name;
  String country;
  String city;
  String dobstring;
  String gender;
  String about;
  String height;
  String occupation;
  String education;
   
  List<Image> images;

  UserData(Map profile){

    this.id=profile["id"];
    this.name=profile["name"];
    this.email=profile["email"];
    this.id=profile["id"];
    this.first_name=profile["first_name"];
    this.last_name=profile["last_name"];

    this.country=profile["country"];
    this.city=profile["city"];
    this.dobstring=profile["dobstring"];
    this.gender=profile["gender"];
    this.height=profile["height"];
    this.occupation=profile["occupation"];
    this.education=profile["education"];
    this.about=profile["about"];
  }


  int getAge(){

    if (dobstring!=null){
      return MiscUtil.CalculateAge(dobstring);

    }else{
      return null;
    }


  }


  UserData.Direct(this.id,this.name,this.email,this.first_name,this.last_name);
//                  this.country,this.city);
  
  
}