import 'package:flutter/material.dart';

part 'homescreen_event.dart';
part 'homescreen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent,HomeScreenState>{
  List<String> tasks = [];
 HomeScreenBloc() : super(){
   on<AddTaskEvent>((event, emit)=> addTask(event, emit));
 }
}

extension CommonExt on HomeScreenBloc{
  void addTask(AddTaskEvent event, emit){
    tasks.add(event.addTask!);
    emit(AddTaskState(addedTask: event.addTask!));
  }
  void deleteTask(DeleteTaskEvent event, emit){
    tasks.remove(event.deleteTask!);
    emit(DeleteTaskState(deleteTask: event.deleteTask!));
  }
}