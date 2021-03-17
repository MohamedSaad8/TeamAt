import 'package:get/get.dart';
import 'package:team_at/view/chat_view.dart';
import 'package:team_at/view/all_groups_view.dart';
import 'package:team_at/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:team_at/view/profile_view.dart';

class ControlHomeViewModel extends GetxController
{
  int _navigatorValue = 0 ;
  int get navigatorValue => _navigatorValue ;
  Widget _currentScreen = HomeView() ;
  Widget get currentScreen => _currentScreen ;

  void changeSelectedValue(int currentIndex){
    _navigatorValue = currentIndex ;
    switch(currentIndex)
    {
      case 0 : _currentScreen =  HomeView();
      break;
      case 1 : _currentScreen =  GroupsView();
      break;
      case 2 : _currentScreen =  Container();
      break;
      case 3 : _currentScreen =  ChatView();
      break;
      case 4 : _currentScreen =  ProfileView();
      break;


    }
    update();
  }
}