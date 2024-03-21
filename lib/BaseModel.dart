import "package:scoped_model/scoped_model.dart";

//здесь будет вся логика обработки данных и переменных
class BaseModel extends Model {

  int stackIndex = 0; //какое из экранов отображается
  List entityList = []; //лист с данными из вкладок
  var entityBeingEdited; //ссылка на объект для редактирования текущего списка
  String chosenDate = ""; // дата выбранная пользователем

  //метод для возврата выбранной даты
  void setChosenDate(String date) {
    print("## BaseModel.setChosenDate(): inDate = $date");
    chosenDate = date;
    notifyListeners();   //изменяет виджеты которые подключены к модели
  }

  //метод для операций в entityList
  void loadData(String entityType, dynamic database) async {
    print("## ${entityType}Model.loadData()");
    entityList = await database.getAll();
    notifyListeners();
  }

  //вызывается когда мы перемещаемся между экранами
  void setStackIndex(int inStackIndex) {
    print("## BaseModel.setStackIndex(): inStackIndex = $inStackIndex");
    stackIndex = inStackIndex;
    notifyListeners();
  }
}