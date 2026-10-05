abstract class ServiceLayoutStates{}

class ServiceLayoutInitialStates extends ServiceLayoutStates{}

class ServiceLayoutLoadingStates extends ServiceLayoutStates{}

class ServiceLayoutLoginStates extends ServiceLayoutStates{}

class ServiceLayoutErrorStates extends ServiceLayoutStates{}

class ServiceLayoutChangeBottomNavState extends ServiceLayoutStates{}

class ServiceGetUserLoadingState extends ServiceLayoutStates{}

class ServiceGetUserSuccessState extends ServiceLayoutStates{}

class ServiceGetUserErrorState extends ServiceLayoutStates{
  final String error;
  ServiceGetUserErrorState(this.error);
}

class ServiceGetAllUsersLoadingState extends ServiceLayoutStates{}

class ServiceGetAllUsersSuccessState extends ServiceLayoutStates{}

class ServiceGetAllUsersErrorState extends ServiceLayoutStates
{
  final String error;

  ServiceGetAllUsersErrorState(this.error);
}

class ServiceProfileImagePickedSuccessState extends ServiceLayoutStates{}

class ServiceProfileImagePickedErrorState extends ServiceLayoutStates{}

class ServiceUploadProfileImageSuccessState extends ServiceLayoutStates{}

class ServiceUploadProfileImageErrorState extends ServiceLayoutStates{}

class ServiceUserUpdateErrorState extends ServiceLayoutStates{}

class ServiceUserUpdateLoadingState extends ServiceLayoutStates{}

class ServiceGetOrdersLoadingState extends ServiceLayoutStates{}

class ServiceGetOrdersSuccessState extends ServiceLayoutStates{}

class ServiceGetOrdersErrorState extends ServiceLayoutStates
{
  final String error;

  ServiceGetOrdersErrorState(this.error);
}
class ServiceGetOffersLoadingState extends ServiceLayoutStates{}

class ServiceGetOffersSuccessState extends ServiceLayoutStates{}

class ServiceGetOffersErrorState extends ServiceLayoutStates{
  final String error;

  ServiceGetOffersErrorState(this.error);
}
class ServiceAcceptOfferLoadingState extends ServiceLayoutStates{}

class ServiceAcceptOfferSuccessState extends ServiceLayoutStates{}

class ServiceAcceptOfferErrorState extends ServiceLayoutStates{
  final String error;

  ServiceAcceptOfferErrorState(this.error);
}