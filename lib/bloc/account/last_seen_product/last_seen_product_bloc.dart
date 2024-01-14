import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/account/last_seen_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class LastSeenProductBloc extends Bloc<LastSeenProductEvent, LastSeenProductState> {
  LastSeenProductBloc() : super(InitialLastSeenProductState()){
    on<GetLastSeenProduct>(_getLastSeenProduct);
  }
}

void _getLastSeenProduct(GetLastSeenProduct event, Emitter<LastSeenProductState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(LastSeenProductWaiting());
  try {
    List<LastSeenModel> data = await _apiProvider.getLastSeenProduct(event.sessionId, event.skip, event.limit, event.apiToken);
    emit(GetLastSeenProductSuccess(lastSeenData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(LastSeenProductError(errorMessage: ex.toString()));
    }
  }
}