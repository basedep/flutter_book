import "dart:io";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "BaseModel.dart";

Directory? docsDir;

Future selectDate(
    BuildContext context,
    BaseModel model,
    String dateString)
async {

  DateTime initialDate = DateTime.now();

  if (dateString != null) {
    List dateParts = dateString.split(","); //разделяем дату на части

    initialDate = DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2])
    );
  }

  //отображает всплывающий календарь
  DateTime? picked = await showDatePicker(
      context : context,
      initialDate : initialDate,
      firstDate : DateTime(1900),
      lastDate : DateTime(2100)
  );

  if (picked != null) {
    model.setChosenDate(DateFormat.yMMMMd("en_US").format(picked.toLocal()));
    return "${picked.year},${picked.month},${picked.day}";
  }

}