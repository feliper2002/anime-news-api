import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class ContentPage extends StatelessWidget {
  final String title;
  final String content;
  const ContentPage({
    Key? key,
    this.content = '',
    this.title = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.black),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HtmlWidget(content),
            ],
          ),
        ),
      ),
    );
  }
}
