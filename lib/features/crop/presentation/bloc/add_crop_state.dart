import 'package:clean_architecture_poktani/features/crop/domain/entity/response/entity_response_add_crop.dart';
import 'package:equatable/equatable.dart';

abstract class AddCropState extends Equatable {
  const AddCropState();

  @override
  List<Object> get props => [];
}

// State awal, saat halaman baru dibuka
class AddCropInitial extends AddCropState {}

// State saat sedang mengirim data ke API
class AddCropLoading extends AddCropState {}

// State saat berhasil menambahkan data, membawa data tanaman yang baru dibuat
class AddCropSuccess extends AddCropState {
  final DataCrop crop;

  const AddCropSuccess(this.crop);

  @override
  List<Object> get props => [crop];
}

// State saat terjadi error
class AddCropFailure extends AddCropState {
  final String message;

  const AddCropFailure(this.message);

  @override
  List<Object> get props => [message];
}
