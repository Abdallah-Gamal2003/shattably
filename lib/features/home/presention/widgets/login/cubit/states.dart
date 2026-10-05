abstract class ServiceLoginStates {}

class ServiceLoginInitialState extends ServiceLoginStates {}

class ServiceLoginLoadingState extends ServiceLoginStates {}

class ServiceLoginSuccessState extends ServiceLoginStates {

  final String uId;

  ServiceLoginSuccessState(this.uId);
}

class ServiceLoginErrorState extends ServiceLoginStates {
  final String error;
  ServiceLoginErrorState(this.error);
}

class ServiceChangePasswordVisibilityState extends ServiceLoginStates {}
