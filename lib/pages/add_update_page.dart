
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_bloc/bloc/note_bloc.dart';
import 'package:todo_bloc/models/note_model.dart';
import 'package:todo_bloc/widgets/custom_app_bar.dart';

import '../app_constants.dart';


class AddUpdatePage extends StatefulWidget {
  const AddUpdatePage({Key? key, this.noteModel,this.index}) : super(key: key);
  final int? index;
  final NoteModel? noteModel;

  @override
  State<AddUpdatePage> createState() => _AddUpdatePageState();
}

class _AddUpdatePageState extends State<AddUpdatePage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  TextEditingController? titleController;
  TextEditingController? descriptionController;
  int currentIndex = 0;


  @override
  void initState() {
    super.initState();
    if(widget.noteModel!=null){
      titleController = TextEditingController(text:widget.noteModel!.title);
      descriptionController = TextEditingController(text:widget.noteModel!.description);
      currentIndex = widget.noteModel!.color;
    }else{
      titleController = TextEditingController();
      descriptionController = TextEditingController();
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CustomAppBar(
                    title: widget.noteModel !=null?'Update Note':'Add note',
                    icon: Icons.check,
                    onPressed: () {
                      if (globalKey.currentState!.validate()) {
                        final note = NoteModel(
                          title: titleController!.text,
                          description: descriptionController!.text,
                          date: widget.noteModel!=null?widget.noteModel!.date :DateFormat('dd-mm-yyyy').format(DateTime.now()),
                          color:currentIndex ,
                        );
                        if(widget.noteModel!=null){
                          context.read<NoteBloc>().add(UpdateNoteEvent(note,widget.index!));
                        }else{
                          context.read<NoteBloc>().add(AddNoteEvent(note));
                        }

                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 50),
                CustomTextFormField(
                    labelText: 'Title',
                    controller:titleController!,
                    maximumLines: 1),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: descriptionController!,
                  labelText: 'Description',
                  maximumLines: 4,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: AppConstants.colors.length,
                        itemBuilder: (context, index) {
                          return  Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 8),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                    currentIndex = index;
                                });
                               },
                              child: ColorItem(
                                color:AppConstants.colors[index],
                                isActive: currentIndex == index,
                                priority: AppConstants.priorities[index],
                              ),
                            ),
                          );
                        }),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.maximumLines,
  });

  final TextEditingController controller;
  final int? maximumLines;
  final String labelText;

  // String validator(String? text) {
  //   return 'Filed can\'t be Empty';
  // }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // validator: validator,
      controller: controller,
      maxLines: maximumLines,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 2,
                color: Colors.grey,
              ))),
    );
  }
}

class ColorItem extends StatelessWidget {
  const ColorItem({Key? key, required this.isActive, required this.color,required this.priority})
      : super(key: key);

  final bool isActive;
  final Color color;
  final String priority;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isActive
            ? CircleAvatar(
          radius: 18,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 14,
            backgroundColor: color,
          ),
        )
            : CircleAvatar(
          radius: 18,
          backgroundColor: color,
        ),
        SizedBox(height: 4,),
        Text(priority,style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),),
      ],
    );
  }
}


