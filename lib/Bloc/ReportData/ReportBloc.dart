//
//
//
//
// import 'package:bloc/bloc.dart';
//
//
// import '../../Service/SendReportService.dart';
// import 'ReportEvent.dart';
// import 'ReportState.dart';
//
// class ServiceBloc extends Bloc<ServiceEvent,ServiceState>{
//   ServiceBloc(): super(ServiceInitialState()){
//
//
//     on<onPressedEvent>((event,emit) async{
//       emit(ServiceLoadingState());
//
//
//       dynamic result = await SendReportService().sendData();
//       if(result == ConstantsMessage.serveError){
//         emit(ServiceErrorState(ConstantsMessage.serveError));
//       }else if (result == ConstantsMessage.statusError) {
//         emit(ServiceErrorState(ConstantsMessage.statusError));
//       }else{
//         emit(ServiceSuccessState());
//       }
//
//     });
//   }
// }