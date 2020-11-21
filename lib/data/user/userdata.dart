

class UserData{

  String id;
  String name;
  String email;
  String first_name;
  String last_name;

  UserData(Map fbprofile){

    this.id=fbprofile["id"];
    this.name=fbprofile["name"];
    this.email=fbprofile["email"];
    this.id=fbprofile["id"];
    this.first_name=fbprofile["first_name"];
    this.last_name=fbprofile["last_name"];
  }

  UserData.Direct(this.id,this.name,this.email,this.first_name,this.last_name);
}