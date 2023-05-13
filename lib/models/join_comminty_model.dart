class JoinPlanModel {
  String? authorName;
  String? authorID;
  String? authorImage;
  String? planDate;
  String? planName;
  String? planDescription;
  String? planImage;
  String? planID;

  JoinPlanModel(this.authorName, this.authorID, this.authorImage, this.planName,
      this.planDate, this.planImage, this.planDescription, this.planID);

  // Named Constructor to get Recipe Data from FireStore
  JoinPlanModel.fromJson({required Map<String, dynamic> json}) {
    authorImage = json['userImage'];
    authorID = json['userID'];
    authorName = json['userName'];
    planImage = json['recipeImage'];
    planDate = json['planDate'];
    planName = json['planName'];
    planDescription = json['planDescription'];
    planID = json['planID'];
  }

  // TOJson used it when i will sent data to fireStore
  Map<String, dynamic> toJson() {
    return {
      'userName': authorName,
      'userID': authorID,
      'userImage': authorImage,
      'planName': planName,
      'planDescription': planDescription,
      'planDate': planDate,
      'recipeImage': planImage,
      'planID': planID,
    };
  }
}
