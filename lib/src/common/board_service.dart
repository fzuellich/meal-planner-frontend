import 'dart:async';
import 'package:angular2/angular2.dart';

import 'board.dart';
import 'mock_boards.dart';

@Injectable()
class BoardService {

  /**
   * Get all boards for a user.
   */
  Future<List<Board>> getBoards() async => mockBoards;

}