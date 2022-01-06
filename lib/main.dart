import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intoxianimeapi/core/app_widget.dart';

void main() => BlocOverrides.runZoned(() => runApp(const AppWidget()));
