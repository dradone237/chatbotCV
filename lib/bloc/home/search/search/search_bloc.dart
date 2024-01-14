import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/search/search_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitialSearchState()){
    on<GetSearch>(_getSearch);
  }
}

void _getSearch(GetSearch event, Emitter<SearchState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(SearchWaiting());
  try {
    List<SearchModel> data = await _apiProvider.getSearch(event.sessionId, event.apiToken);
    emit(GetSearchSuccess(searchData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(SearchError(errorMessage: ex.toString()));
    }
  }
}