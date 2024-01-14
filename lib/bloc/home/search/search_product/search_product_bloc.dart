import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/search/search_product_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  SearchProductBloc() : super(InitialSearchProductState()){
    on<GetSearchProduct>(_getSearchProduct);
  }
}

void _getSearchProduct(GetSearchProduct event, Emitter<SearchProductState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(SearchProductWaiting());
  try {
    List<SearchProductModel> data = await _apiProvider.getSearchProduct(event.sessionId, event.search, event.skip, event.limit, event.apiToken);
    emit(GetSearchProductSuccess(searchProductData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(SearchProductError(errorMessage: ex.toString()));
    }
  }
}