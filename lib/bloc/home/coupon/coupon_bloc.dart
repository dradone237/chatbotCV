import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/home/coupon_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(InitialCouponState()){
    on<GetCoupon>(_getCoupon);
    on<GetCouponDetail>(_getCouponDetail);
  }
}

void _getCoupon(GetCoupon event, Emitter<CouponState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(CouponWaiting());
  try {
    List<CouponModel> data = await _apiProvider.getCoupon(event.sessionId, event.skip, event.limit, event.apiToken);
    emit(GetCouponSuccess(couponData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(CouponError(errorMessage: ex.toString()));
    }
  }
}

void _getCouponDetail(GetCouponDetail event, Emitter<CouponState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(CouponDetailWaiting());
  try {
    CouponModel data = await _apiProvider.getCouponDetail(event.sessionId, event.id, event.apiToken);
    emit(GetCouponDetailSuccess(couponData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(CouponDetailError(errorMessage: ex.toString()));
    }
  }
}