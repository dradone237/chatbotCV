import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/recomended_product_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class RecomendedProductBloc extends Bloc<RecomendedProductEvent, RecomendedProductState> {
  RecomendedProductBloc() : super(InitialRecomendedProductState()){
    on<GetRecomendedProduct>(_getRecomendedProduct);
  }
}

void _getRecomendedProduct(GetRecomendedProduct event, Emitter<RecomendedProductState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(RecomendedProductWaiting());
  try {
    List<RecomendedProductModel> data = await _apiProvider.getRecomendedProduct(event.sessionId, event.skip, event.limit, event.apiToken);
    emit(GetRecomendedProductSuccess(recomendedProductData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(RecomendedProductError(errorMessage: ex.toString()));
    }
  }
}