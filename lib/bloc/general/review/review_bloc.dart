import 'package:bloc/bloc.dart';
import 'package:ijshopflutter/model/general/review_model.dart';
import 'package:ijshopflutter/network/api_provider.dart';
import './bloc.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(InitialReviewState()){
    on<GetReview>(_getReview);
    on<GetReviewProduct>(_getReviewProduct);
  }
}

void _getReview(GetReview event, Emitter<ReviewState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(ReviewWaiting());
  try {
    List<ReviewModel> data = await _apiProvider.getReview(event.sessionId, event.skip, event.limit, event.apiToken);
    emit(GetReviewSuccess(reviewData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(ReviewError(errorMessage: ex.toString()));
    }
  }
}

void _getReviewProduct(GetReviewProduct event, Emitter<ReviewState> emit) async {
  ApiProvider _apiProvider = ApiProvider();

  emit(ReviewProductWaiting());
  try {
    List<ReviewModel> data = await _apiProvider.getReview(event.sessionId, event.skip, event.limit, event.apiToken);
    emit(GetReviewProductSuccess(reviewData: data));
  } catch (ex){
    if(ex != 'cancel'){
      emit(ReviewProductError(errorMessage: ex.toString()));
    }
  }
}