import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/category/category_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(InitialCategoryState()){
    on<GetCategory>(_getCategory);
  }
}

void _getCategory(GetCategory event, Emitter<CategoryState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(CategoryWaiting());
  try {
    List<CategoryModel> data = await _apiProvider.getCategory(event.sessionId, event.apiToken);
    emit(GetCategorySuccess(categoryData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(CategoryError(errorMessage: ex.toString()));
    }
  }
}