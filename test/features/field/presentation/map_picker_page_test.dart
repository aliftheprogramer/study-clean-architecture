import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/response_address_detail_entity.dart';
import 'package:clean_architecture_poktani/features/field/presentation/map/bloc/map_cubit.dart';
import 'package:clean_architecture_poktani/features/field/presentation/map/bloc/map_state.dart';
import 'package:clean_architecture_poktani/features/field/presentation/map/pages/widget/map_picker_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';

// 1. Buat MockCubit menggunakan bloc_test
class MockMapCubit extends MockCubit<MapState> implements MapCubit {}

void main() {
  // Deklarasikan mock cubit yang akan digunakan di semua tes
  late MockMapCubit mockMapCubit;

  // setUp akan dijalankan sebelum setiap tes
  setUp(() {
    mockMapCubit = MockMapCubit();
  });

  // Fungsi helper untuk membangun widget yang akan dites
  // Ini penting untuk menyediakan MaterialApp dan BlocProvider
  Widget createTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<MapCubit>.value(value: mockMapCubit, child: child),
    );
  }

  group('MapPickerPage Widget Tests', () {
    testWidgets(
      'harus menampilkan peta tanpa marker saat state awal (Initial)',
      (widgetTester) async {
        // Atur state awal untuk mock cubit
        when(() => mockMapCubit.state).thenReturn(MapInitial());

        // Bangun UI
        await widgetTester.pumpWidget(
          createTestableWidget(const MapPickerPage()),
        );

        // Verifikasi
        expect(find.byType(FlutterMap), findsOneWidget); // Peta harus ada
        expect(
          find.byType(MarkerLayer),
          findsNothing,
        ); // Marker tidak boleh ada
        expect(find.byType(Card), findsNothing); // Kartu alamat tidak boleh ada
        expect(
          find.byType(CircularProgressIndicator),
          findsNothing,
        ); // Loading tidak boleh ada
      },
    );

    testWidgets(
      'harus menampilkan CircularProgressIndicator saat state Loading',
      (widgetTester) async {
        // Atur state loading
        when(() => mockMapCubit.state).thenReturn(MapLoading());

        // Bangun UI
        await widgetTester.pumpWidget(
          createTestableWidget(const MapPickerPage()),
        );

        // Verifikasi
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets('harus menampilkan marker dan kartu alamat saat state Loaded', (
      widgetTester,
    ) async {
      // ... (kode persiapan data dummy sama seperti sebelumnya)
      final testLatLng = LatLng(-6.9, 107.6);
      final testAddress = AddressDetailEntity(
        latitude: -6.9,
        longitude: 107.6,
        road: 'Test Address',
        village: 'Cibaduyut',
        subdistrict: 'Bojongloa',
        city: 'Bandung',
      );

      whenListen(
        mockMapCubit,
        Stream.fromIterable([
          MapLoaded(selectedLocation: testLatLng, address: testAddress),
        ]),
        initialState: MapInitial(),
      );

      await widgetTester.pumpWidget(
        createTestableWidget(const MapPickerPage()),
      );

      // ✅ GANTI DENGAN pumpAndSettle() DI SINI JUGA
      await widgetTester.pumpAndSettle();

      // Verifikasi
      expect(find.byType(Card), findsOneWidget);
      expect(find.byIcon(Icons.location_pin), findsOneWidget);
      expect(find.textContaining('Dusun:'), findsOneWidget);
      expect(
        find.text('Lokasi ditemukan!'),
        findsOneWidget,
      ); // Ini sekarang lebih andal
    });
    testWidgets(
      'harus menampilkan SnackBar dengan pesan error saat state Error',
      (widgetTester) async {
        // Atur stream untuk emit state error
        whenListen(
          mockMapCubit,
          Stream.fromIterable([MapError('Gagal memuat')]),
          initialState: MapInitial(),
        );

        // Bangun UI
        await widgetTester.pumpWidget(
          createTestableWidget(const MapPickerPage()),
        );

        // Pump sekali lagi agar SnackBar muncul
        await widgetTester.pump();

        // Verifikasi
        expect(
          find.text('Gagal memuat'),
          findsOneWidget,
        ); // Pesan error di SnackBar
        expect(find.byType(Card), findsNothing); // Kartu alamat tidak boleh ada
        expect(
          find.byType(MarkerLayer),
          findsNothing,
        ); // Marker tidak boleh ada
      },
    );
  });
}
