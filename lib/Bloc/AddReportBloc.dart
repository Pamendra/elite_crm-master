


import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Service/SendReportService.dart';
import '../Utils/message_contants.dart';

class AddReportState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AddreportInitialState extends AddReportState{}


class AddreportLoadingState extends AddReportState{}


class AddreportSuccessState extends AddReportState{}


class AddreportErrorState extends AddReportState{
  late  String error;

  AddreportErrorState(this.error);
}


abstract class AddreportEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


class onPressedButtonEvent extends AddreportEvent{
  String leadId;
  String name;
  String cname;
  String gmanager;
  String pmanager;
  String services;
  String category;
  String status;
  String vdate;
  String dealerIds;
  String gnote;
  String dealernotes;

  onPressedButtonEvent(
      {required this.leadId,
        required this.name,
        required  this.cname,
        required  this.gmanager,
        required  this.pmanager,
        required  this.services,
        required  this.category,
        required  this.status,
        required   this.vdate,
        required  this.dealerIds,
        required   this.gnote,
        required   this.dealernotes});
}

class AddreportBloc extends Bloc<AddreportEvent,AddReportState>{
  AddreportBloc(): super(AddreportInitialState()){


    on<onPressedButtonEvent>((event,emit) async{
      emit(AddreportLoadingState());


      dynamic result = await Addreportdata().sendData(event.leadId,event.name,event.cname,event.gmanager,event.pmanager,event.services,
      event.category,event.status,event.vdate,event.dealerIds,event.gnote,event.dealernotes);
      if(result == ConstantsMessage.serveError){
        emit(AddreportErrorState(ConstantsMessage.serveError));
      }else if (result == ConstantsMessage.statusError) {
        emit(AddreportErrorState(ConstantsMessage.statusError));
      }else{
        emit(AddreportSuccessState());
        Fluttertoast.showToast(msg: 'Report Added Successfully');
      }

    });
  }
}

