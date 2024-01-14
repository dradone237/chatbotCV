import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/last_search_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class LastSearchBloc extends Bloc<LastSearchEvent, LastSearchState> {
  LastSearchBloc() : super(InitialLastSearchState()){
    on<GetLastSearchHome>(_getLastSearchHome);
    on<GetLastSearch>(_getLastSearch);
  }
}

void _getLastSearchHome(GetLastSearchHome event, Emitter<LastSearchState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(LastSearchHomeWaiting());
  try {
    List<LastSearchModel> data = await _apiProvider.getLastSearch(event.sessionId, event.skip, event.limit, event.apiToken);
    emit(GetLastSearchHomeSuccess(lastSearchData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(LastSearchHomeError(errorMessage: ex.toString()));
    }
  }
}

void _getLastSearch(GetLastSearch event, Emitter<LastSearchState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(LastSearchWaiting());
  try {
    List<LastSearchModel> data = await _apiProvider.getLastSearchInfinite(event.sessionId, event.skip, event.limit, event.apiToken);
    emit(GetLastSearchSuccess(lastSearchData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(LastSearchError(errorMessage: ex.toString()));
    }
  }
}