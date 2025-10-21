import 'package:car_parts_app/presentation/category/bloc/category_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Drawerv2 extends StatelessWidget {
  const Drawerv2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoaded) {
                  return Column(
                    children: state.products
                        .map(
                          (e) => CheckboxListTile(
                            value: false,
                            onChanged: (value) {},
                            title: Text(e.carCategory),
                          ),
                        )
                        .toList(),
                  );
                }
                return Container();
              },
            ),
            ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
          ],
        ),
      ),
    );
  }
}
