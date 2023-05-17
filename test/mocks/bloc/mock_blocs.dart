import 'package:flutter_base_template_1/modules/detail/bloc/detail_bloc.dart';
import 'package:flutter_base_template_1/modules/home/bloc/home_bloc.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<HomeBloc>(),
  MockSpec<DetailBloc>(),
])
void main() {}
