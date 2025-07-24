import 'package:clean_architecture_poktani/features/field/presentation/list_field/bloc/field_cubit.dart';
import 'package:clean_architecture_poktani/features/field/presentation/list_field/bloc/field_state.dart';
import 'package:clean_architecture_poktani/features/field/presentation/list_field/pages/widget/item_list_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FieldMainPage extends StatelessWidget {
  const FieldMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lahanku',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black87,
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: BlocProvider(
        create: (context) => ListFieldCubit()..loadListFields(),
        child: _FieldListView(),
      ),
    );
  }
}

class _FieldListView extends StatefulWidget {
  @override
  State<_FieldListView> createState() => _FieldListViewState();
}

class _FieldListViewState extends State<_FieldListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ListFieldCubit>().loadListFields();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListFieldCubit, ListFieldState>(
      builder: (context, state) {
        if (state is ListFieldInitial ||
            (state is ListFieldLoading && state is! ListFieldLoaded)) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ListFieldError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (state is ListFieldLoaded) {
          if (state.fields.isEmpty) {
            return const Center(child: Text('Tidak ada data lahan.'));
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedMax
                ? state.fields.length
                : state.fields.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.fields.length) {
                return const Center(child: CircularProgressIndicator());
              }
              final field = state.fields[index];
              return ItemListField(listFieldEntity: field);
            },
          );
        }

        return const Center(
          child: Text("Terjadi kesalahan yang tidak diketahui."),
        );
      },
    );
  }
}
