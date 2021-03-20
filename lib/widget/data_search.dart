import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/model/group_model.dart';
import 'package:team_at/view/group_view.dart';
import 'package:team_at/viewModel/posts_view_model.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataSearch extends SearchDelegate<String> {
  List<GroupModel> allGroups;
  GroupModel searchedGroup ;

  DataSearch({this.allGroups});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print("//////////////////////////////////////////////////////////////");
    print("//////////////////////////////////////////////////////////////");
    return GroupView(thisGroup: searchedGroup,);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<GroupModel> searchList = allGroups
        .where((p) => p.groupName.toLowerCase().startsWith(query.toLowerCase())).toList();

    return query != ""
        ? ListView.builder(
            itemBuilder: (context, index) {
              return GetBuilder<PostsViewModel>(
                init:  PostsViewModel(),
                builder: (postCont) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10 ,vertical: 20),
                  child: InkWell(
                    onTap: () async{
                      query = searchList[index].groupName;
                      searchedGroup = searchList[index];
                      await postCont.getGroupPostsFromFireStore(searchedGroup.groupID);
                      showResults(context);
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16.w,
                          backgroundImage: NetworkImage(searchList[index].groupPictureURL),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        CustomText(
                          text:searchList[index].groupName,
                          fontSize: 16.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: searchList.length,
          )
        : Container();
  }
}
