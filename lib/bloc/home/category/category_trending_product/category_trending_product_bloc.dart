import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/category/category_trending_product_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class CategoryTrendingProductBloc extends Bloc<CategoryTrendingProductEvent, CategoryTrendingProductState> {
  CategoryTrendingProductBloc() : super(InitialCategoryTrendingProductState()){
    on<GetCategoryTrendingProduct>(_getCategoryTrendingProduct);
  }
}

void _getCategoryTrendingProduct(GetCategoryTrendingProduct event, Emitter<CategoryTrendingProductState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(CategoryTrendingProductWaiting());
  try {
    List<CategoryTrendingProductModel> data = await _apiProvider.getCategoryTrendingProduct(event.sessionId, event.categoryId, event.skip, event.limit, event.apiToken);
    emit(GetCategoryTrendingProductSuccess(categoryTrendingProductData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(CategoryTrendingProductError(errorMessage: ex.toString()));
    }
  }
}