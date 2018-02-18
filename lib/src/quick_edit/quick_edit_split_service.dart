import 'package:angular/di.dart';

@Injectable()
class QuickEditSplitService {

  List<String> splitApart(String input) {
    return _splitByBrackets(input);
  }

  List<String> _splitByBrackets(String input) {
    int indexOfOpeningBracket = input.indexOf('(');
    int indexOfClosingBracket = input.indexOf(')');

    bool hasOpeningBracket = indexOfOpeningBracket != -1;
    bool hasClosingBracket = indexOfClosingBracket != -1;

    if (!hasOpeningBracket || !hasClosingBracket) {
      return [input];
    }

    List<String> result = new List();
    result.add(input.substring(0, indexOfOpeningBracket).trim());
    result.add(input.substring(indexOfOpeningBracket, indexOfClosingBracket + 1).trim());

    if (input.substring(indexOfClosingBracket + 1).isNotEmpty) {
      List<String> rest = _splitByBrackets(input.substring(indexOfClosingBracket + 1).trim());
      result.addAll(rest);
    }

    return result;

  }
}