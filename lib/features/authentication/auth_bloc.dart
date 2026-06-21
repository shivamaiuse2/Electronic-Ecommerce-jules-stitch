import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../shared/models/user.dart';
import '../../core/services/local_storage_service.dart';

// Events
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final User user;
  AuthLoggedIn(this.user);
  @override
  List<Object?> get props => [user];
}

class AuthLoggedOut extends AuthEvent {}

// State
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  AuthAuthenticated(this.user);
  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthCheckRequested>((event, emit) {
      final userId = LocalStorageService.getString('user_id');
      if (userId != null) {
        emit(AuthAuthenticated(User(
          id: userId,
          name: 'John Doe',
          email: 'john@example.com',
          phoneNumber: '+1234567890',
        )));
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<AuthLoggedIn>((event, emit) {
      LocalStorageService.setString('user_id', event.user.id);
      emit(AuthAuthenticated(event.user));
    });

    on<AuthLoggedOut>((event, emit) {
      LocalStorageService.remove('user_id');
      emit(AuthUnauthenticated());
    });
  }
}
