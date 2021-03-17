import 'package:team_at/model/user_model.dart';

class GroupModel
{
  String groupID ;
  String groupName ;
  String groupPictureURL ;
  String groupDescription ;
  double groupLatitude ;
  double groupLongitude ;
  String admin ;
  var confirmedUsers ;
  var unConfirmedUsers ;


  GroupModel(
      {this.groupID,
      this.groupName,
      this.groupPictureURL,
      this.groupDescription,
      this.confirmedUsers,
        this.groupLatitude,
        this.groupLongitude,
      this.unConfirmedUsers,
      this.admin ,
      });

  GroupModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    groupID   = map["groupID"];
    groupName = map["groupName"];
    groupPictureURL    = map["groupPictureURL"];
    groupDescription   = map["groupDescription"];
    unConfirmedUsers    = map["unConfirmedUsers"];
    confirmedUsers = map["confirmedUsers"];
    groupLongitude = map["groupLongitude"];
    groupLatitude     = map["groupLatitude"];
    admin = map["admin"];
  }

  toJson() {
    return {
      "groupID": groupID,
      "groupName": groupName,
      "groupPictureURL": groupPictureURL,
      "groupDescription": groupDescription ,
      "unConfirmedUsers" : unConfirmedUsers,
      "confirmedUsers" : confirmedUsers ,
      "groupLongitude" : groupLongitude ,
      "groupLatitude" : groupLatitude,
      "admin" : admin
    };
  }



}