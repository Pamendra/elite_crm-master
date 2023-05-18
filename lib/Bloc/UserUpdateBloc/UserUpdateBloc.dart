






import 'package:bloc/bloc.dart';

import '../../Service/Update User Data/UpdateUserData.dart';
import '../../Utils/message_contants.dart';

abstract class UserUpdateState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class UserUpdateInitialState extends UserUpdateState{}


class UserUpdateLoadingState extends UserUpdateState{}


class UserUpdateSuccessState extends UserUpdateState{}


class UserUpdateErrorState extends UserUpdateState{
  late  String error;

  UserUpdateErrorState(this.error);
}






abstract class UserUpdateEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


class onPressedEvent extends UserUpdateEvent{
  String address;
  String email;
  String phone;
  String territories;

  onPressedEvent(
      {
        required this.address,
        required this.email,
        required this.phone,
        required this.territories,
      });
}


class UserUpdateBloc extends Bloc<UserUpdateEvent,UserUpdateState>{
  UserUpdateBloc(): super(UserUpdateInitialState()){


    on<onPressedEvent>((event,emit) async{
      emit(UserUpdateLoadingState());


      dynamic result = await UpdateUserdata().sendData(event.address,event.email,event.phone,event.territories);
      if(result == ConstantsMessage.serveError){
        emit(UserUpdateErrorState(ConstantsMessage.serveError));
      }else if (result == ConstantsMessage.statusError) {
        emit(UserUpdateErrorState(ConstantsMessage.statusError));
      }else{
        emit(UserUpdateSuccessState());
      }

    });
  }
}
