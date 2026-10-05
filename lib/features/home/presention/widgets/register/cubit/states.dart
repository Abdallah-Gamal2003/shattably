class  ServiceRegisterStates{}

class ServiceRegisterInitialState extends ServiceRegisterStates{}

class ServiceRegisterLoadingState extends ServiceRegisterStates{}

class ServiceRegisterSuccessState extends ServiceRegisterStates{}

class ServiceRegisterErrorState extends ServiceRegisterStates{
  final String error;
  ServiceRegisterErrorState(this.error);
}

class ServiceRegisterCreateUserSuccessState extends ServiceRegisterStates{}

class ServiceCreateUserErrorState extends ServiceRegisterStates{
  final String error;
  ServiceCreateUserErrorState(this.error);
}

class ServiceRegisterChangePasswordVisibilityState extends ServiceRegisterStates{}