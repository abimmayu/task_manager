import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashStarted>((event, emit) async => checkInternet(emit));
  }

  Future<void> checkInternet(
    Emitter<SplashState> emit,
  ) async {
    final isConnected = await InternetConnectionChecker.instance.hasConnection;
    log("isConnected: $isConnected");

    if (isConnected) {
      emit(SplashHaveInternet());
    } else {
      emit(SplashNoInternet());
    }
  }
}
