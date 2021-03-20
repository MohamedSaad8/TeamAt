import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:team_at/model/group_model.dart';
import 'package:team_at/model/user_model.dart';
import 'package:team_at/view/group_view.dart';
import 'package:team_at/viewModel/group_view_model.dart';

class MapView extends StatelessWidget {
  List<Marker> markers =[] ;

  final markersData ;

  MapView(this.markersData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  GetBuilder<GroupViewModel>(
        init: GroupViewModel(),
        builder: (controller) => Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: controller.getTeamAtGroups(),
            builder:(context , snapShot) {
              markers.clear();
              if(snapShot.hasData)
              {
                int index = 0 ;
                for (var doc in snapShot.data.docs) {
                  var data = doc.data();
                  markers.add(Marker(
                    infoWindow: InfoWindow(
                      title: data["groupName"],
                    ),
                    markerId: MarkerId(data["groupID"]),
                    position: LatLng(data["groupLatitude"],data["groupLongitude"]),
                    icon: BitmapDescriptor.fromBytes(markersData[index]),
                    onTap: (){
                      Get.to(()=> GroupView(thisGroup: GroupModel.fromJson(data),));
                    }

                  ));
                  index ++ ;

                }
                print(markers.length);
              }
              return GoogleMap(
                markers: Set.from(markers),
                initialCameraPosition:  CameraPosition(
                    target: LatLng(
                        UserModel.currentUser.latitude ,UserModel.currentUser.longitude
                    ),
                    zoom: 10.0
                ),
                mapType: MapType.normal,
              );
            }
          ),
        ),
      ),
    );
  }
}
