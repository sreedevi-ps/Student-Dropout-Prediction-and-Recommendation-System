part of 'menu_changer_bloc.dart';

@immutable
sealed class MenuChangerEvent {}

class MenuChangeRequested extends MenuChangerEvent {
  final int index;
  final Widget screen;

  MenuChangeRequested({required this.index, required this.screen});
}
