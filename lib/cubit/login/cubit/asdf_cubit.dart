import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asdf_state.dart';

class AsdfCubit extends Cubit<AsdfState> {
  AsdfCubit() : super(AsdfInitial());
}
