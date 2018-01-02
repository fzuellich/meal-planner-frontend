import 'dart:async';
import 'dart:html';
import 'dart:convert';
import 'package:angular/angular.dart';

import 'board.dart';
import 'mock_boards.dart';

@Injectable()
class BoardService {

  /**
   * Get all boards for a user.
   */
  Future<List<Board>> getBoards() async {
    try {
      String json = await HttpRequest.getString(
          "https://localhost:8443/boards");
      if (json.contains("Login Page")) {
        return mockBoards;
      }

      List<Board> result = JSON.decode(json)
          .map((var board) => _createBoardFromJSONObject(board))
          .toList();

      return result;
    } catch (e) {
      return mockBoards;
    }
  }

  Board _createBoardFromJSONObject(var jsonObject) {
    return new Board.withData(jsonObject['id'], jsonObject['name'], jsonObject['url']);
  }

}