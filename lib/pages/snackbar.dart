import 'package:flutter/material.dart';

showSnackBar(SnackBar snackBar, 
  {required BuildContext context, required String text, bool isError = true
  }
){
  SnackBar snackBar = SnackBar(content: Text(text),);
}