import 'dart:async';
import 'package:angular/angular.dart';

import 'package:meal_planner_frontend/src/common/board_service.dart';
import 'package:meal_planner_frontend/src/common/board.dart';

@Component(
  selector: 'board-browser',
  templateUrl: 'board_browser_component.html',
  styleUrls: const ['board_browser_component.css'],
  directives: const [NgFor],
  providers: const [BoardService])

class BoardBrowserComponent implements OnInit {

  final BoardService _boardService;

  List<Board >boards;

  Board selectedBoard;

  final _boardChange = new StreamController<Board>();

  @Output()
  Stream<Board> get selectedBoardChange => _boardChange.stream;

  BoardBrowserComponent(this._boardService);

  void ngOnInit() => initializeBoardList();

  /**
   * Fetch all boards for the current user.
   */
  void initializeBoardList() => _boardService.getBoards().then((boards) => this.boards = boards);

  /**
   * Choose a selected board.
   */
  void selectBoard(Board instance) {
    if (selectedBoard != null) {
      selectedBoard.status = 'default';
    }

    // Allow to toggle
    if (selectedBoard == instance) {
      selectedBoard = null;
    } else {
      selectedBoard = instance;
      selectedBoard.status = 'selected';
    }

    _boardChange.add(selectedBoard);
  }

}
