import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/trending_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class HomeTrendingBloc extends Bloc<HomeTrendingEvent, HomeTrendingState> {
  HomeTrendingBloc() : super(InitialHomeTrendingState()){
    on<GetHomeTrending>(_getHomeTrending);
  }
}

void _getHomeTrending(GetHomeTrending event, Emitter<HomeTrendingState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(HomeTrendingWaiting());
  try {
    List<HomeTrendingModel> data = await _apiProvider.getHomeTrending(event.sessionId, event.skip, event.limit, event.apiToken);
    emit(GetHomeTrendingSuccess(homeTrendingData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(HomeTrendingError(errorMessage: ex.toString()));
    }
  }
}