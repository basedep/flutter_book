import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "NotesDBWorker.dart";
import "NotesModel.dart" show Note, NotesModel, notesModel;

class NotesList extends StatelessWidget {

  Widget build(BuildContext inContext) {

    print("## NotesList.build()");

    // Return widget.
    return ScopedModel<NotesModel>(
        model : notesModel,
        child : ScopedModelDescendant<NotesModel>(
            builder : (BuildContext inContext, Widget? inChild, NotesModel inModel) {
              return Scaffold(
                // Add note.
                  floatingActionButton : FloatingActionButton(
                      child : Icon(Icons.add, color : Colors.white),
                      onPressed : () async {
                        notesModel.entityBeingEdited = Note();
                        notesModel.setColor(null);
                        notesModel.setStackIndex(1);
                      }
                  ),
                  body : ListView.builder(
                      itemCount : notesModel.entityList.length,
                      itemBuilder : (BuildContext inBuildContext, int inIndex) {
                        Note note = notesModel.entityList[inIndex];
                        // Determine note background color (default to white if none was selected).
                        Color color = Colors.white;
                        switch (note.color) {
                          case "red" : color = Colors.red; break;
                          case "green" : color = Colors.green; break;
                          case "blue" : color = Colors.blue; break;
                          case "yellow" : color = Colors.yellow; break;
                          case "grey" : color = Colors.grey; break;
                          case "purple" : color = Colors.purple; break;
                        }
                        return Container(
                            padding : EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child : Slidable(
                                startActionPane: const ActionPane(
                                  motion: ScrollMotion(),
                                  extentRatio: .25,
                                  children: [
                                  ],
                                ),
                                child : Card(
                                    elevation : 8,
                                    color : color,
                                    child : ListTile(
                                        title : Text("${note.title}"),
                                        subtitle : Text("${note.content}"),
                                        onTap : () async {
                                          notesModel.entityBeingEdited = await NotesDBWorker.db.get(note.id);
                                          notesModel.setColor(notesModel.entityBeingEdited.color);
                                          notesModel.setStackIndex(1);
                                        }
                                    )
                                )
                            )
                        );
                      }
                  )
              );
            }
        )
    );

  }


  Future _deleteNote(BuildContext inContext, Note inNote) async {

    return showDialog(
        context : inContext,
        barrierDismissible : false,
        builder : (BuildContext inAlertContext) {
          return AlertDialog(
              title : Text("Delete Note"),
              content : Text("Are you sure you want to delete ${inNote.title}?"),
              actions : [
                MaterialButton(child : Text("Cancel"),
                    onPressed: () {
                      Navigator.of(inAlertContext).pop();
                    }
                ),
                MaterialButton(child : Text("Delete"),
                    onPressed : () async {
                      await NotesDBWorker.db.delete(inNote.id);
                      Navigator.of(inAlertContext).pop();
                      ScaffoldMessenger.of(inContext).showSnackBar(
                         const SnackBar(
                              backgroundColor : Colors.red,
                              duration : Duration(seconds : 2),
                              content : Text("Note deleted")
                          )
                      );
                      // Reload data from database to update list.
                      notesModel.loadData("notes", NotesDBWorker.db);
                    }
                )
              ]
          );
        }
    );

  } /* End _deleteNote(). */


} /* End class. */