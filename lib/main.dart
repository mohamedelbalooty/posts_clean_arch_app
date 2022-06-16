import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'src/features/posts_feature/presentation_layer/bloc/post_bloc/post_bloc.dart';
import 'src/features/posts_feature/presentation_layer/bloc/posts_bloc/posts_bloc.dart';
import 'src/features/posts_feature/presentation_layer/pages/posts_page.dart';
import 'src/utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const CleanArchApp());
}

class CleanArchApp extends StatelessWidget {
  const CleanArchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<PostsBloc>()),
        BlocProvider(create: (_) => di.sl<PostBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme().appTheme,
        home: const PostsPage(),
      ),
    );
  }
}
