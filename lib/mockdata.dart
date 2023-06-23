import 'package:flutter/material.dart';
import 'package:python_project/model/item_list.dart';
import 'package:python_project/model/todo_item.dart';

class MockData {
  static const List<ItemList> itemList = [
    ItemList(name: 'Tests', numberOfTask: 20, completeTask: 5, icon: Icons.note_alt_outlined, color: Colors.blueGrey,photo:'images/Lovepik.png',),
    ItemList(name: 'Paint', numberOfTask: 10, completeTask: 3, icon: Icons.color_lens_outlined, color: Colors.deepPurple,photo:'images/vector-color-paint.png',  ),
    ItemList(name: 'DR.chatGPT', numberOfTask: 15, completeTask: 15, icon: Icons.child_care_outlined, color: Colors.teal,photo: 'images/chatg.png',),
    ItemList(name: 'Ideas', numberOfTask: 10, completeTask: 8, icon: Icons.lightbulb_outline, color: Colors.orangeAccent,photo: 'images/idea.png', ),
  ];

  static const List<ToDoItem> todoList = [
    ToDoItem(
        name: 'Break',
        details: 'Break to lunch - Go to JC Burger',
        remainder: true,
        time: '12 PM',
        detailTime: '12 PM - 1:30 PM',
        color: Colors.teal),
    ToDoItem(
        name: 'Create design proposal',
        details: 'Continue with design for challenge',
        remainder: false,
        time: '2 PM',
        detailTime: '2 PM - 4:30 PM',
        color: Colors.teal),
    ToDoItem(
        name: 'Meeting with team',
        details: 'Meeting to create release to production for client',
        remainder: true,
        time: '5 PM',
        detailTime: '5 PM - 6 PM',
        color: Colors.teal),
    ToDoItem(
        name: 'Art exhibition in the museum',
        details: 'Friends meetup',
        remainder: false,
        time: '6 PM',
        detailTime: '6 PM - 8 PM',
        color: Colors.deepPurple),
    ToDoItem(
        name: 'Walk with dog',
        details: 'Go with halley to the park',
        remainder: true,
        time: '9 PM',
        detailTime: '9 PM - 10 PM',
        color: Colors.green),
  ];
}
