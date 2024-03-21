import "../BaseModel.dart";

class Note {
  late int id;
  late String title;
  late String content;
  late String color;

  String toString() {
    return "{ id=$id, title=$title, content=$content, color=$color }";
  }
}

class NotesModel extends BaseModel {

  String color = "";

  void setColor(String? color) {
    this.color = color!;
    notifyListeners();
  }
}
NotesModel notesModel = NotesModel();