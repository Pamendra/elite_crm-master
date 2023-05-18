


abstract class ServiceState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ServiceInitialState extends ServiceState{}


class ServiceLoadingState extends ServiceState{}


class ServiceSuccessState extends ServiceState{}


class ServiceErrorState extends ServiceState{
  late  String error;

  ServiceErrorState(this.error);
}