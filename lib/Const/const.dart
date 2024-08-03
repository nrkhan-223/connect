

import 'package:path_provider/path_provider.dart';

// String BaseUrl="https://new.goshrt.com/api";
 String BaseUrl="https://linkapp.xyz/api";
 String media="https://linkapp.xyz/uploads/";
 String categoryMedia="https://linkapp.xyz/uploads/category";



 init() async {
  documentPath = "${(await getApplicationDocumentsDirectory()).path}/";
}

 String documentPath = '';