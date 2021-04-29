import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_complete/business_logic/cubit/internet_cubit.dart';
import 'package:flutter_bloc_complete/constants/enums.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  StreamSubscription internetStreamSubscription;

  CounterCubit({@required this.internetCubit}) : super(CounterState(counterValue: 0)){
    monitorInternetCubit();
  }

  StreamSubscription<InternetState> monitorInternetCubit() {
    return  internetStreamSubscription=internetCubit.listen((internetState) {
      if(internetState is InternetConnected && internetState.connectionType==ConnectionType.Wifi ){
        increment();
      }else if(internetState is InternetConnected && internetState.connectionType==ConnectionType.Mobile ){
        dicrement();
      }
    });
  }

  void increment()=> emit(CounterState(counterValue:state.counterValue+1,wasIncremented: true ));
  void dicrement()=> emit(CounterState(counterValue:state.counterValue-1,wasIncremented: false  ));


  @override
  Future<void> close() {
    internetStreamSubscription.cancel();
    return super.close();
  }
}
