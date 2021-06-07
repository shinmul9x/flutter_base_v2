import 'package:flutter/material.dart';

void clearFocus(BuildContext context) =>
    FocusScope.of(context).requestFocus(FocusNode());
