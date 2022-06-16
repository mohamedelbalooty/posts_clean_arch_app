import 'package:flutter/material.dart';
import 'package:tdd_app/src/features/posts_feature/presentation_layer/widgets/shared_widgets.dart';
import 'package:tdd_app/src/utils/theme/colors.dart';
import '../../domain_layer/entities/post_entity.dart';
import '../bloc/post_bloc/post_bloc.dart';
import '../bloc/post_bloc/post_event.dart';

void showSnackBar(BuildContext context,
    {required String message, required Color color}) {
  ScaffoldMessenger.of(context)
      .showSnackBar(snackBarWidget(message: message, color: color));
}

SnackBar snackBarWidget({required String message, required Color color}) =>
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: whiteClr,
          fontSize: 20,
        ),
      ),
      backgroundColor: color,
    );

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key, required this.isUpdate, this.post})
      : super(key: key);
  final bool isUpdate;
  final Post? post;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  late TextEditingController _titleController;

  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      _titleController = TextEditingController(text: widget.post!.title);
      _bodyController = TextEditingController(text: widget.post!.body);
    } else {
      _titleController = TextEditingController();
      _bodyController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormFieldUtil(
                controller: _titleController,
                hint: 'Post Title',
                onValidate: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter post title please !';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 20),
              TextFormFieldUtil(
                controller: _bodyController,
                hint: 'Post Body',
                maxLines: 4,
                onValidate: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter post body please !';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButtonUtil(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.isUpdate ? Icons.edit : Icons.add,
                      size: 22,
                      color: whiteClr,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.isUpdate ? 'Update' : 'Create',
                      style: const TextStyle(
                        color: whiteClr,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                onClick: _onValidate,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onValidate() {
    final PostBloc bloc = PostBloc.get(context);
    if (_globalKey.currentState!.validate()) {
      if (!widget.isUpdate) {
        bloc.add(
          CreatePostEvent(
            post:
                Post(title: _titleController.text, body: _bodyController.text),
          ),
        );
      } else {
        if (_titleController.text == widget.post!.title &&
            _bodyController.text == widget.post!.body) {
          showSnackBar(context, message: 'No Changes yet!', color: Colors.red);
        } else {
          bloc.add(
            UpdatePostEvent(
              post: Post(
                  id: widget.post!.id,
                  title: _titleController.text,
                  body: _bodyController.text),
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}
