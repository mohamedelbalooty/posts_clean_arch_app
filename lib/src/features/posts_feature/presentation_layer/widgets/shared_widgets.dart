import 'package:flutter/material.dart';
import '../../../../utils/theme/colors.dart';
import '../../domain_layer/entities/post_entity.dart';

AppBar appBarUtil({required String title}) => AppBar(
      title: Text(title),
    );

class LoadingUtil extends StatelessWidget {
  const LoadingUtil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(mainClr),
      ),
    );
  }
}

class TextFormFieldUtil extends StatelessWidget {
  const TextFormFieldUtil({
    Key? key,
    required this.controller,
    required this.hint,
    required this.onValidate,
    this.maxLines = 1,
  }) : super(key: key);
  final TextEditingController controller;
  final String hint;
  final String? Function(String?) onValidate;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: onValidate,
      cursorColor: mainClr,
      maxLines: maxLines,
      style: const TextStyle(
        color: mainClr,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: mainClr,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: _border(),
        focusedBorder: _border(),
        errorBorder: _border(),
        focusedErrorBorder: _border(),
      ),
    );
  }

  OutlineInputBorder _border() => const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        borderSide: BorderSide(
          width: 2,
          color: mainClr,
        ),
      );
}

class ElevatedButtonUtil extends StatelessWidget {
  const ElevatedButtonUtil(
      {Key? key, required this.child, required this.onClick, this.color = mainClr})
      : super(key: key);
  final Widget child;
  final Color color;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: child,
      onPressed: onClick,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(10)),
        backgroundColor: MaterialStateProperty.all<Color>(color),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}

class PostWidgetUtil extends StatelessWidget {
  const PostWidgetUtil({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        borderSide: BorderSide(
          width: 2,
          color: mainClr,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(
                color: mainClr,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Text(
              post.body,
              style: const TextStyle(
                color: greyClr,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


void onNavigate(BuildContext context, {required Widget page}) => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );

void onPop(BuildContext context) => Navigator.pop(context);
