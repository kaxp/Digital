import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_state.dart';

class DetailBloc extends Cubit<DetailState> {
  DetailBloc() : super(DetailInitial());
}
