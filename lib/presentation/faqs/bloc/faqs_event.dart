part of 'faqs_bloc.dart';

abstract class FaqsEvent extends Equatable {
  const FaqsEvent();

  @override
  List<Object> get props => [];
}

class toggleFaqExpansion extends FaqsEvent {}
