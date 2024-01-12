// #3
import 'package:mobx/mobx.dart';

part 'discover_store.g.dart';

// #2
class DiscoverStore = _DiscoverStore with _$DiscoverStore;

// #1
abstract class _DiscoverStore with Store {}
