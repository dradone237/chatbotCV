import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/category/category_all_product_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class CategoryAllProductBloc extends Bloc<CategoryAllProductEvent, CategoryAllProductState> {
  CategoryAllProductBloc() : super(InitialCategoryAllProductState()){
    on<GetCategoryAllProduct>(_getCategoryAllProduct);
  }
}

void _getCategoryAllProduct(GetCategoryAllProduct event, Emitter<CategoryAllProductState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(CategoryAllProductWaiting());
  try {
    List<CategoryAllProductModel> data = await _apiProvider.getCategoryAllProduct(event.sessionId, event.categoryId, event.skip, event.limit, event.apiToken);
    emit(GetCategoryAllProductSuccess(categoryAllProductData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(CategoryAllProductError(errorMessage: ex.toString()));
    }
  }
}
