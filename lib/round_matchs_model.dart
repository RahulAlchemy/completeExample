import 'package:flutter/cupertino.dart';

import 'round_response.dart';

class RoundMatches<T>{
  List<T> teams;
  GlobalKey? key;
  RoundMatches(this.teams,this.key);
}