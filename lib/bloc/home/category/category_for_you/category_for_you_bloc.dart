import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/category/category_for_you_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class CategoryForYouBloc extends Bloc<CategoryForYouEvent, CategoryForYouState> {
  CategoryForYouBloc() : super(InitialCategoryForYouState()){
    on<GetCategoryForYou>(_getCategoryForYou);
  }
}

void _getCategoryForYou(GetCategoryForYou event, Emitter<CategoryForYouState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(CategoryForYouWaiting());
  try {
    List<CategoryForYouModel> data = await _apiProvider.getCategoryForYou(event.sessionId, event.apiToken);
    emit(GetCategoryForYouSuccess(categoryForYouData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(CategoryForYouError(errorMessage: ex.toString()));
    }
  }
}