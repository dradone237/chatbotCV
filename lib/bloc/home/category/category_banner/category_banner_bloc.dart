import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/category/category_banner_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class CategoryBannerBloc extends Bloc<CategoryBannerEvent, CategoryBannerState> {
  CategoryBannerBloc() : super(InitialCategoryBannerState()){
    on<GetCategoryBanner>(_getCategoryBanner);
  }
}

void _getCategoryBanner(GetCategoryBanner event, Emitter<CategoryBannerState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(CategoryBannerWaiting());
  try {
    List<CategoryBannerModel> data = await _apiProvider.getCategoryBanner(event.sessionId, event.categoryId, event.apiToken);
    emit(GetCategoryBannerSuccess(categoryBannerData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(CategoryBannerError(errorMessage: ex.toString()));
    }
  }
}