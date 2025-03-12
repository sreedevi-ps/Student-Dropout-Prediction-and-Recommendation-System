part of 'menu_changer_bloc.dart';

@immutable
sealed class MenuChangerState {}
 final class MenuChangerInitial extends MenuChangerState {}
final class MenuChangerChangedSuccess extends MenuChangerState {
  final int index;
  final Widget screen;
  MenuChangerChangedSuccess({required this.index, required this.screen});
}


