import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

enum SortOption { popularity, priceLowToHigh, priceHighToLow, newest }

class FilterState extends Equatable {
  final String? query;
  final String? category;
  final double minPrice;
  final double maxPrice;
  final SortOption sortOption;

  const FilterState({
    this.query,
    this.category,
    this.minPrice = 0,
    this.maxPrice = 5000,
    this.sortOption = SortOption.popularity,
  });

  FilterState copyWith({
    String? query,
    String? category,
    double? minPrice,
    double? maxPrice,
    SortOption? sortOption,
  }) {
    return FilterState(
      query: query ?? this.query,
      category: category ?? this.category,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      sortOption: sortOption ?? this.sortOption,
    );
  }

  @override
  List<Object?> get props => [query, category, minPrice, maxPrice, sortOption];
}

abstract class FilterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateFilters extends FilterEvent {
  final String? query;
  final String? category;
  final double? minPrice;
  final double? maxPrice;
  final SortOption? sortOption;

  UpdateFilters({this.query, this.category, this.minPrice, this.maxPrice, this.sortOption});

  @override
  List<Object?> get props => [query, category, minPrice, maxPrice, sortOption];
}

class ResetFilters extends FilterEvent {}

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(const FilterState()) {
    on<UpdateFilters>((event, emit) {
      emit(state.copyWith(
        query: event.query,
        category: event.category,
        minPrice: event.minPrice,
        maxPrice: event.maxPrice,
        sortOption: event.sortOption,
      ));
    });

    on<ResetFilters>((event, emit) {
      emit(const FilterState());
    });
  }
}
