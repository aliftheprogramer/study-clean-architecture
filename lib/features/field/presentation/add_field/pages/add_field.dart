// import 'package:clean_architecture_poktani/features/field/presentation/add_field/bloc/add_field_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AddFieldPage extends StatelessWidget {
//   const AddFieldPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Tambah Lahan',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         foregroundColor: Colors.black87,
//         centerTitle: true,
//         toolbarHeight: 80,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: MultiBlocProvider(
//         providers: [BlocProvider(create: (context) => AddFieldCubit())],
//         child: BlocBuilder<AddFieldCubit, AddFieldState>(
//           builder: (context, state) {
//             if (state is AddFieldInitial) {
//               return _bodyFormAddField(context);
//             } else if (state is AddFieldLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is AddFieldSuccess) {
//               return const Center(child: Text('Lahan berhasil ditambahkan'));
//             } else if (state is AddFieldFailure) {
//               return Center(
//                 child: Text('Gagal menambahkan lahan: ${state.error}'),
//               );
//             } else {
//               return const SizedBox.shrink(); // Default case
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _bodyFormAddField(BuildContext context) {
//     // This method should return the form for adding a field.
//     // For now, we will return a placeholder widget.
//     return Center(
//       child: Text('Form untuk menambahkan lahan akan ditampilkan di sini.'),
//     );
//   }
// }
