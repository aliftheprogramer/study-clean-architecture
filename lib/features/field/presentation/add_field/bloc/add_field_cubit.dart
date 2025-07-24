// import 'package:clean_architecture_poktani/core/services/services_locator.dart';
// import 'package:clean_architecture_poktani/features/field/data/model/request/request_add_field.dart';
// import 'package:clean_architecture_poktani/features/field/domain/usecase/add_field_usecase.dart';
// import 'package:clean_architecture_poktani/features/field/presentation/add_field/bloc/add_field_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AddFieldCubit extends Cubit<AddFieldState> {
//   final AddFieldUsecase _addFieldUseCase = sl<AddFieldUsecase>();

//   AddFieldCubit() : super(AddFieldInitial());

//   Future<void> addField(AddFieldRequestModel params) async {
//     emit(AddFieldLoading());
//     final result = await _addFieldUseCase(params);
//     result.fold(
//       (failure) => emit(AddFieldFailure(failure.message)),
//       (field) => emit(AddFieldSuccess(field)),
//     );
//   }
// }
