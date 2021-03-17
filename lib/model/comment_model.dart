class CommentModel

{
  String commentContent;
  String postId;
  String userId;
  String commentId;

  CommentModel(
      {this.commentContent,
        this.postId,
        this.userId,
        this.commentId
      });

  CommentModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    postId   = map["postId"];
    commentContent = map["commentContent"];
    userId    = map["userId"];
    commentId = map["commentId"];

  }

  toJson() {
    return {
      "postId": postId,
      "commentContent": commentContent,
      "userId" : userId,
      "commentId" :commentId
    };
  }
}