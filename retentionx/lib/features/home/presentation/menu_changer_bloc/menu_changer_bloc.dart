import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'menu_changer_event.dart';
part 'menu_changer_state.dart';

class MenuChangerBloc extends Bloc<MenuChangerEvent, MenuChangerState> {
  MenuChangerBloc() : super(MenuChangerInitial()) {
    on<MenuChangeRequested>((event, emit) {
      try {
        emit(MenuchangerLoading());
        emit(MenuChangerChangedSuccess(
          index: event.index,
          screen: event.screen,
        ));
      } catch (e) {
        print(e);
      }
    });
  }
}
