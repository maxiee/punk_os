/*
Copyright 2021 The dahliaOS Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'package:flutter/material.dart';

class Taskbar extends StatefulWidget {
  final List<Widget>? leading;
  final List<Widget>? trailing;

  const Taskbar({
    required this.leading,
    required this.trailing,
    Key? key,
  }) : super(key: key);

  @override
  State<Taskbar> createState() => _TaskbarState();
}

class _TaskbarState extends State<Taskbar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      height: 48,
      child: Container(
        child: Material(
          color: Colors.grey.shade50.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Stack(
              children: [
                Row(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.leading ?? [const SizedBox.shrink()],
                    ),
                    Expanded(child: Container()),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.trailing ?? [const SizedBox.shrink()],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
