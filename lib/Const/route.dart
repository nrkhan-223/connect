

import 'package:flutter/material.dart';

newPage({required BuildContext context, required Widget child})=>
  Navigator.push(context, MaterialPageRoute(builder: (context)=>child));
