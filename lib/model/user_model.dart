import 'package:team_at/helper/constant.dart';

class UserModel {
  String email;
  String userName;
  String picURL;
  String userID;
  String name;
  String longitude;
  String latitude;
  String phone;

  UserModel(
      {this.email,
      this.userName,
      this.picURL,
      this.userID,
      this.name,
      this.longitude,
      this.latitude,
      this.phone});

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    userID   = map[kUserID];
    userName = map[kUserName];
    email    = map[kEmail];
    picURL   = map[kPicURL];
    phone    = map[kPhone];
    latitude = map[kLatitude];
    longitude = map[kLongitude];
    name     = map[kName];
  }

  toJson() {
    return {
      kUserID: userID,
      kUserName: userName,
      kEmail: email,
      kPicURL: picURL ,
      kPhone : phone,
      kLatitude : latitude ,
      kLongitude : longitude ,
      kName : name

    };
  }
}
