abstract class LayoutStates {}

class InitialAppState extends LayoutStates {}

class ChangeBottomNavIndexState extends LayoutStates {}

class ChangeJoinPlanShownState extends LayoutStates {}

// for get my data

class GetUserDataLoadingState extends LayoutStates {}

class GetUserDataSuccessState extends LayoutStates {}

class GetUserDataErrorState extends LayoutStates {}

class LogOutLoadingState extends LayoutStates {}

// for get users data to show in chat screen and search for a user using it

class GetUsersDataSuccessState extends LayoutStates {}

// for update my data either profileImage , name , email , bio , website link

class GetProfileImageLoadingState extends LayoutStates {}

class GetProfileImageSuccessState extends LayoutStates {}

class GetProfileImageErrorState extends LayoutStates {}

class UpdateUserDataWithoutImageLoadingState extends LayoutStates {}

class UpdateUserDataWithoutImageSuccessState extends LayoutStates {}

class UpdateUserDataWithoutImageErrorState extends LayoutStates {}

class UpdateUserDataWithImageLoadingState extends LayoutStates {}

class UpdateUserDataWithImageErrorState extends LayoutStates {}

class ErrorDuringOpenWebsiteUrlState extends LayoutStates {}

class UploadUserImageErrorState extends LayoutStates {}

class CanceledUpdateUserDataState extends LayoutStates {}

class ChosenImageSuccessfullyState extends LayoutStates {}

class ChosenImageErrorState extends LayoutStates {}

// for Create new Recipe || update Recipe || delete Recipe

class SelectPlanImageErrorState extends LayoutStates {}

class SelectPlanImageSuccessState extends LayoutStates {}

// Todo: create plan || delete it
class CreateMyPlanLoadingState extends LayoutStates {}

class CreateMyPlanSuccessfullyState extends LayoutStates {}

class FailedToCreateMyPlanState extends LayoutStates {}

class DeletePlanLoadingState extends LayoutStates {}

class DeletePlanSuccessfullyState extends LayoutStates {}

class FailedToDeletePlanState extends LayoutStates {
  final String error;
  FailedToDeletePlanState({required this.error});
}

class FailedToaddToJoinedPlanState extends LayoutStates {}

class addToJoinedPlanSuccessfullyState extends LayoutStates {}

class addToJoinedPlanLoadingState extends LayoutStates {}

class LeavePlanLoadingState extends LayoutStates {}

class LeavePlanSuccessfullyState extends LayoutStates {}

class LeavePlanWithErrorState extends LayoutStates {
  final String error;
  LeavePlanWithErrorState({required this.error});
}

class GetOtherPlansSuccessState extends LayoutStates {}

class GetOtherPlansErrorState extends LayoutStates {}

class GetOtherPlansLoadingState extends LayoutStates {}

class UpdatePlanLoadingState extends LayoutStates {}

class UpdatePlanSuccessfullyState extends LayoutStates {}

class UpdateRecipeErrorState extends LayoutStates {}

class CanceledPlanImageState extends LayoutStates {}

// for get All plans for all users

class GetMyPlansLoadingState extends LayoutStates {}

class GetMyPlansSuccessState extends LayoutStates {}

class GetMyPlansErrorState extends LayoutStates {}

class GetJoinedPlansLoadingState extends LayoutStates {}

class GetJoinedPlansSuccessState extends LayoutStates {}

class GetJoinedPlansErrorState extends LayoutStates {}

class FilteredOtherPlansSuccessState extends LayoutStates {}

class FilteredOtherPlansLoadingState extends LayoutStates {}

// for add a comment and like on Recipe || delete it

class ChosenrecipeImageSuccessfullyState extends LayoutStates {}

class ChosenrecipeImageErrorState extends LayoutStates {}

class UploadRecipeWithoutImageLoadingState extends LayoutStates {}

class UploadRecipeWithImageLoadingState extends LayoutStates {}

class UploadRecipeWithoutImageSuccessState extends LayoutStates {}

class UploadRecipeWithImageErrorState extends LayoutStates {}

class UploadImageForRecipeErrorState extends LayoutStates {}

class CanceledImageForRecipeState extends LayoutStates {}

class DeleteRecipeLoadingState extends LayoutStates {}

class DeleteRecipeSuccessState extends LayoutStates {}

class DeleteRecipeErrorState extends LayoutStates {}

class UpdateRecipeSuccessState extends LayoutStates {}

class UpdateRecipeLoadingState extends LayoutStates {}

class AddLikeSuccessfullyState extends LayoutStates {}

class AddLikeErrorState extends LayoutStates {}

class RemoveLikeSuccessfullyState extends LayoutStates {}

class RemoveLikeErrorState extends LayoutStates {}

class GetLikeStatusForMeOnSpecificRecipeLoadingState extends LayoutStates {}

class GetLikeStatusForMeOnSpecificRecipeSuccessState extends LayoutStates {}

class GetLikesLoadingState extends LayoutStates {}

class GetLikesSuccessfullyState extends LayoutStates {}

class GetCommentsLoadingState extends LayoutStates {}

class GetCommentsSuccessState extends LayoutStates {}

class GetCommentsErrorState extends LayoutStates {}

class DeleteCommentSuccessState extends LayoutStates {}

class AddCommentSuccessState extends LayoutStates {}

class FailedToAddCommentState extends LayoutStates {}

class FailedToDeleteCommentState extends LayoutStates {}

class FailedToGetJoinedRecipesState extends LayoutStates {}

class GetJoinedRecipesSuccessState extends LayoutStates {}

class GetAllRecipesSuccessfullyState extends LayoutStates {}

class GetAllRecipesLoadingState extends LayoutStates {}

class FailedToGetAllRecipesState extends LayoutStates {}
