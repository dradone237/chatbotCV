import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/home_banner_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class HomeBannerBloc extends Bloc<HomeBannerEvent, HomeBannerState> {
  HomeBannerBloc() : super(InitialHomeBannerState()){
    on<GetHomeBanner>(_getHomeBanner);
  }
}

void _getHomeBanner(GetHomeBanner event, Emitter<HomeBannerState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(HomeBannerWaiting());
  try {
    List<HomeBannerModel> data = await _apiProvider.getHomeBanner(event.sessionId, event.apiToken);
    emit(GetHomeBannerSuccess(homeBannerData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(HomeBannerError(errorMessage: ex.toString()));
    }
  }
}