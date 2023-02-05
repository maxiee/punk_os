import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PreviewBlock extends StatefulWidget {
  const PreviewBlock({super.key});

  @override
  State<PreviewBlock> createState() => _PreviewBlockState();
}

class _PreviewBlockState extends State<PreviewBlock> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
