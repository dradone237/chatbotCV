import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/wishlist/wishlist_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(InitialWishlistState()){
    on<GetWishlist>(_getWishlist);
  }
}

void _getWishlist(GetWishlist event, Emitter<WishlistState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(WishlistWaiting());
  try {
    List<WishlistModel> data = await _apiProvider.getWishlist(event.sessionId, event.apiToken);
    emit(GetWishlistSuccess(wishlistData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(WishlistError(errorMessage: ex.toString()));
    }
  }
}
