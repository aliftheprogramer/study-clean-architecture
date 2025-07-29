// file: features/field/presentation/detail_field/bloc/detail_field_bloc.dart

import 'package:clean_architecture_poktani/features/field/domain/entity/response/detail_field/response_detail_field_entity.dart';
import 'package:equatable/equatable.dart';

// -- EVENTS --
abstract class DetailFieldEvent extends Equatable {
  const DetailFieldEvent();
  @override
  List<Object?> get props => [];
}

class FetchDetailField extends DetailFieldEvent {
  final int fieldId;
  const FetchDetailField(this.fieldId);
  @override
  List<Object?> get props => [fieldId];
}

// -- STATES --
abstract class DetailFieldState extends Equatable {
  const DetailFieldState();
  @override
  List<Object?> get props => [];
}

class DetailFieldInitial extends DetailFieldState {}

class DetailFieldLoading extends DetailFieldState {}

class DetailFieldLoaded extends DetailFieldState {
  final FieldDetailEntity fieldDetail;
  const DetailFieldLoaded(this.fieldDetail);
  @override
  List<Object?> get props => [fieldDetail];
}

class DetailFieldError extends DetailFieldState {
  final String message;
  const DetailFieldError(this.message);
  @override
  List<Object?> get props => [message];
}

// =======================================================================
// ===                    DATA DUMMY YANG DIPERBAIKI                   ===
// =======================================================================

// 1. DATA LENGKAP (ada tanaman, pupuk, dan pestisida)
final Map<String, dynamic> dummyDataFull = {
  "data": {
    "id": 1,
    "name": "Lahan Subur Jaya",
    "owner": {"id": 1, "name": "Budi Santoso"},
    "land_area": 150,
    "picture_url": null,
    "address": {
      "sub_village": "Cisauk",
      "village": "Tangerang",
      "district": "Banten",
    },
    "coordinates": {"latitude": "-6.3320", "longitude": "106.6321"},
    "soil_type": "Andosol",
    "created_at": "2025-07-30T02:00:00.000000Z",
    "updated_at": "2025-07-30T02:00:00.000000Z",
    // BENAR: 'active_crop' sekarang ada di dalam 'data'
    "active_crop": {
      "id": 1,
      "planting_date": "2025-07-14",
      "seed": {"name": "Padi Sawah", "variety": "Ciherang"},
      "coordinator_name": "Mitra Tani Sejahtera",
      "fertilizers_used": [
        {
          "application_date": "2025-07-14",
          "name": "Pupuk NPK Mutiara",
          "quantity": 2,
          "unit": "kg",
        },
      ],
      "pesticides_used": [
        {
          "application_date": "2025-07-20",
          "name": "Insektisida Decis",
          "quantity": 50,
          "unit": "ml",
        },
      ],
    },
  },
};

// 2. DATA TANPA PUPUK/PESTISIDA (ada tanaman, tapi list pupuk/pestisida kosong)
final Map<String, dynamic> dummyDataNoFertilizer = {
  "data": {
    "id": 5,
    "name": "Lahan Harapan",
    "owner": {"id": 2, "name": "Siti Aminah"},
    "land_area": 200,
    "picture_url": null,
    "address": {
      "sub_village": "Karawaci",
      "village": "Tangerang",
      "district": "Banten",
    },
    "coordinates": {"latitude": "-6.2234", "longitude": "106.6075"},
    "soil_type": "Latosol",
    "created_at": "2025-07-30T01:00:00.000000Z",
    "updated_at": "2025-07-30T01:00:00.000000Z",
    // BENAR: 'active_crop' sekarang ada di dalam 'data'
    "active_crop": {
      "id": 5,
      "planting_date": "2025-07-14",
      "seed": {"name": "Jagung Manis", "variety": "Bonanza"},
      "coordinator_name": "Tani Makmur",
      "fertilizers_used": [], // <-- List kosong
      "pesticides_used": [], // <-- List kosong
    },
  },
};

// 3. DATA TANPA TANAMAN (active_crop bernilai null)
final Map<String, dynamic> dummyDataNoCrop = {
  "data": {
    "id": 28,
    "name": "Lahan Istirahat",
    "owner": {"id": 5, "name": "Joko"},
    "land_area": 100,
    "picture_url": null,
    "address": {
      "sub_village": "Cipondoh",
      "village": "Tangerang",
      "district": "Banten",
    },
    "coordinates": {"latitude": "-6.1862", "longitude": "106.7023"},
    "soil_type": "Podsolik",
    "created_at": "2025-07-29T16:00:00.000000Z",
    "updated_at": "2025-07-29T16:00:00.000000Z",
    // BENAR: 'active_crop' ada di dalam 'data' dan nilainya null
    "active_crop": null,
  },
};
