import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/note_bloc.dart';
import 'package:todo_bloc/pages/add_update_page.dart';
import 'package:todo_bloc/widgets/custom_app_bar.dart';
import 'package:todo_bloc/widgets/note_list_item.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 50),
            CustomAppBar(title: 'Notes', icon: Icons.search),
            Expanded(
              child: NoteListItem(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder:(context) => AddUpdatePage())
          );

      },
        child: Icon(Icons.add),
      )
    );
  }
}
