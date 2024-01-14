import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/account/address_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(InitialAddressState()){
    on<GetAddress>(_getAddress);
  }
}

void _getAddress(GetAddress event, Emitter<AddressState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(AddressWaiting());
  try {
    List<AddressModel> data = await _apiProvider.getAddress(event.sessionId, event.apiToken);
    emit(GetAddressSuccess(addressData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(AddressError(errorMessage: ex.toString()));
    }
  }
}