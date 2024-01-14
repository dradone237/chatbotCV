import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/category/category_new_product_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class CategoryNewProductBloc extends Bloc<CategoryNewProductEvent, CategoryNewProductState> {
  CategoryNewProductBloc() : super(InitialCategoryNewProductState()){
    on<GetCategoryNewProduct>(_getCategoryNewProduct);
  }
}

void _getCategoryNewProduct(GetCategoryNewProduct event, Emitter<CategoryNewProductState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(CategoryNewProductWaiting());
  try {
    List<CategoryNewProductModel> data = await _apiProvider.getCategoryNewProduct(event.sessionId, event.categoryId, event.skip, event.limit, event.apiToken);
    emit(GetCategoryNewProductSuccess(categoryNewProductData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(CategoryNewProductError(errorMessage: ex.toString()));
    }
  }
}