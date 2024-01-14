import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/shopping_cart/shopping_cart_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  ShoppingCartBloc() : super(InitialShoppingCartState()){
    on<GetShoppingCart>(_getShoppingCart);
  }
}

void _getShoppingCart(GetShoppingCart event, Emitter<ShoppingCartState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(ShoppingCartWaiting());
  try {
    List<ShoppingCartModel> data = await _apiProvider.getShoppingCart(event.sessionId, event.apiToken);
    emit(GetShoppingCartSuccess(shoppingCartData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(ShoppingCartError(errorMessage: ex.toString()));
    }
  }
}