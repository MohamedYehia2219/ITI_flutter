import 'package:bloc/bloc.dart';
import 'package:cubit_quote_app/model/quote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../datasource/remote/apiservice.dart';
import 'homestates.dart';

class QuoteCubit extends Cubit<QuoteState>{
  QuoteCubit() : super(IntialState());

  static QuoteCubit getInstance(context) => BlocProvider.of(context);
  Quote? quoteObj;
    fetchData() async {
      emit(LoadingState());
      try
      {
        quoteObj = await ApiService.api.fetchQuotes();
        if(quoteObj!=null)
          emit(SuccessState());
        else{emit(ErrorState("error"));
        }
      }catch(e)
      {
        emit(ErrorState("error ${e}"));
      }
  }

}

