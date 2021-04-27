
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_complete/cubit/counter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  group('CounterCubit',(){

    CounterCubit counterCubit;

    setUp((){
        counterCubit=CounterCubit();
    });


    tearDown((){
      counterCubit.close();
    });

    
    test("this initial state for the countercubit is counterState(counterValue:0", (){
      expect(counterCubit.state, CounterState(counterValue: 0));
    });
    
    blocTest('the cubit should emit a counterState(counterValue:1,wasIncrement:true)when cubit.incrememnt() function is called',
        build: ()=>counterCubit,
      act:(cubit)=>cubit.increment(),
      expect: [CounterState(counterValue: 1,wasIncremented: true)],

    );
    blocTest('the cubit should emit a counterState(counterValue:1,wasIncrement:true)when cubit.decrement() function is called',
      build: ()=>counterCubit,
      act:(cubit)=>cubit.dicrement(),
      expect: [CounterState(counterValue: -1,wasIncremented: false)],

    );

  });

}