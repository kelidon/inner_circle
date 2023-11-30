import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState(''));

  void updateSearch(String search) {
    emit(SearchState(search));
  }
}
