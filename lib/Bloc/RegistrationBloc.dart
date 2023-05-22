






import 'package:bloc/bloc.dart';
import '../../Utils/message_contants.dart';
import '../Service/Registration Service.dart';

abstract class regUpdateState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RegUpdateInitialState extends regUpdateState{}


class RegUpdateLoadingState extends regUpdateState{}


class RegUpdateSuccessState extends regUpdateState{}


class RegUpdateErrorState extends regUpdateState{
  late  String error;

  RegUpdateErrorState(this.error);
}






abstract class regUpdateEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


class onPressedButtonEvent extends regUpdateEvent{
  String address;
  String email;
  String phone;
  String territories;
  String shopnamee;
  String owner;
  String c_name;
  String p_name;
  String u_name;
  String Confirm_password;
  onPressedButtonEvent(
      {
        required this.shopnamee,
        required this.address,
        required this.email,
        required this.phone,
        required this.territories,
        required this.owner,
        required this.c_name,
        required this.p_name,
        required this.u_name,
        required this.Confirm_password,
      });
}


class regUpdateBloc extends Bloc<regUpdateEvent,regUpdateState>{
  regUpdateBloc(): super(RegUpdateInitialState()){


    on<onPressedButtonEvent>((event,emit) async{
      emit(RegUpdateLoadingState());


      dynamic result = await Updateregdata().sendData(

        event.shopnamee,
        event.address,
        event.email,
        event.phone,
        event.territories,
        event.owner,
        event.c_name,
        event.u_name,
        event.p_name,
        event.Confirm_password,

      );
      if(result == ConstantsMessage.serveError){
        emit(RegUpdateErrorState(ConstantsMessage.serveError));
      }else if (result == ConstantsMessage.statusError) {
        emit(RegUpdateErrorState(ConstantsMessage.statusError));
      }else{
        emit(RegUpdateSuccessState());
      }

    });
  }
}
