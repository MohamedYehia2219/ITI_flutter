import 'package:cubit_quote_app/model/quote.dart';

abstract class QuoteState {}

class IntialState extends QuoteState{}

class LoadingState extends QuoteState {}

class SuccessState extends QuoteState {}

class ErrorState extends QuoteState {
  String message;
  ErrorState(this.message);
}