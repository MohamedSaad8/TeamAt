
class PostModel
{
  String postContent ;
  String postImageURL ;
  String postId;
  String groupId ;
  String userId ;
  var likes ;
  var comments ;

  PostModel(
      {this.postContent,
        this.postImageURL,
        this.postId,
        this.groupId,
        this.userId,
        this.likes,
        this.comments
      });

  PostModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    postId   = map["postId"];
    postContent = map["postContent"];
    postImageURL    = map["postImageURL"];
    groupId   = map["groupId"];
    userId    = map["userId"];
    likes = map["likes"];
    comments = map["comments"];
  }

  toJson() {
    return {
      "postId": postId,
      "postContent": postContent,
      "postImageURL": postImageURL,
      "groupId": groupId ,
      "userId" : userId,
      "likes" : likes ,
      "comments" : comments
    };
  }

}