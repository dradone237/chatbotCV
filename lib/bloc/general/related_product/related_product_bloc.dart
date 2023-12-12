import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/general/related_product_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class RelatedProductBloc extends Bloc<RelatedProductEvent, RelatedProductState> {
  RelatedProductBloc() : super(InitialRelatedProductState()){
    on<GetRelatedProduct>(_getRelatedProduct);
  }
}

void _getRelatedProduct(GetRelatedProduct event, Emitter<RelatedProductState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(RelatedProductWaiting());
  try {
    List<RelatedProductModel> data = await _apiProvider.getRelatedProduct(event.sessionId, event.apiToken);
    emit(GetRelatedProductSuccess(relatedProductData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(RelatedProductError(errorMessage: ex.toString()));
    }
  }
}