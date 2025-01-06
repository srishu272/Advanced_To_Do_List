part of 'homescreen_bloc.dart';

@immutable
abstract class HomeScreenState {
  const HomeScreenState();
}

class HomeScreenInitial extends HomeScreenState {}

class AddTaskState extends HomeScreenState {
  final String? addedTask;

  AddTaskState({required this.addedTask});
}

class ToggleTaskState extends HomeScreenState{
  final String? toggleTask;

  ToggleTaskState({required this.toggleTask});
}

class DeleteTaskState extends HomeScreenState{
  final String? deleteTask;

  DeleteTaskState({required this.deleteTask});

}

class LoadingState extends HomeScreenState{
  const LoadingState();
}
