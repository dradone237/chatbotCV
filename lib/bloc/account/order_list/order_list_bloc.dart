import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/account/order_list_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  OrderListBloc() : super(InitialOrderListState()){
    on<GetOrderList>(_getOrderList);
  }
}

void _getOrderList(GetOrderList event, Emitter<OrderListState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(OrderListWaiting());
  try {
    List<OrderListModel> data = await _apiProvider.getOrderList(event.sessionId, event.status, event.skip, event.limit, event.apiToken);
    emit(GetOrderListSuccess(orderListData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(OrderListError(errorMessage: ex.toString()));
    }
  }
}