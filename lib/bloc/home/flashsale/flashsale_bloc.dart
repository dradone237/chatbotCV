import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/flashsale_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class FlashsaleBloc extends Bloc<FlashsaleEvent, FlashsaleState> {
  FlashsaleBloc() : super(InitialFlashsaleState()){
    on<GetFlashsaleHome>(_getFlashsaleHome);
    on<GetFlashsale>(_getFlashsale);
  }
}

void _getFlashsaleHome(GetFlashsaleHome event, Emitter<FlashsaleState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(FlashsaleHomeWaiting());
  try {
    List<FlashsaleModel> data = await _apiProvider.getFlashsale(event.sessionId, event.skip, event.limit, event.apiToken);
    emit(GetFlashsaleHomeSuccess(flashsaleData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(FlashsaleHomeError(errorMessage: ex.toString()));
    }
  }
}

void _getFlashsale(GetFlashsale event, Emitter<FlashsaleState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(FlashsaleWaiting());
  try {
    List<FlashsaleModel> data = await _apiProvider.getFlashsale(event.sessionId, event.skip, event.limit, event.apiToken);
    emit(GetFlashsaleSuccess(flashsaleData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(FlashsaleError(errorMessage: ex.toString()));
    }
  }
}