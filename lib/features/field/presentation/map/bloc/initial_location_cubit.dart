import 'package:clean_architecture_poktani/features/field/presentation/map/bloc/initial_location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class InitialLocationCubit extends Cubit<InitialLocationState> {
  InitialLocationCubit() : super(InitialLocationLoading());

  Future<void> fetchInitialLocation() async {
    LatLng locationToSend;
    final defaultLocation = LatLng(
      -6.2088,
      106.8456,
    ); // Lokasi default: Jakarta

    try {
      // Logika pengambilan lokasi sama persis seperti sebelumnya
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        locationToSend = defaultLocation;
      } else {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }

        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          locationToSend = defaultLocation;
        } else {
          final Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          locationToSend = LatLng(position.latitude, position.longitude);
        }
      }
    } catch (e) {
      locationToSend = defaultLocation;
    }

    // Alih-alih navigasi, Cubit akan mengeluarkan state baru
    emit(InitialLocationLoaded(locationToSend));
  }
}
