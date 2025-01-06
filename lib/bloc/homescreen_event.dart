part of 'homescreen_bloc.dart';

@immutable
abstract class HomeScreenEvent {
  const HomeScreenEvent();
}

class AddTaskEvent extends HomeScreenEvent {
  final String? addTask;

  AddTaskEvent({required this.addTask});
}

class ToggleTaskEvent extends HomeScreenEvent {
  final String? toggleTask;

  ToggleTaskEvent({required this.toggleTask});
}

class DeleteTaskEvent extends HomeScreenEvent{
  final String? deleteTask;

  DeleteTaskEvent({required this.deleteTask});
}

class LoadingEvent extends HomeScreenEvent{
  const LoadingEvent();
}
