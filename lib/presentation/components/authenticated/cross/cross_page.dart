import 'package:flutter/material.dart';
import 'package:trifecta/presentation/components/authenticated/cross/cross_tasklist_list_view.dart';
import 'package:trifecta/presentation/components/authenticated/cross/cross_tasks_list_view.dart';

class CrossPage extends StatelessWidget {
  const CrossPage({super.key});

  @override
  Widget build(BuildContext context) {
    String firebaseTaskListId = '';

    void loadTask(String firebaseTaskListId) {
      firebaseTaskListId = firebaseTaskListId;
    }

    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: CrossTaskListListView(
              loadTaskList: loadTask,
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.75,
            child: CrossTasksListView(
              firebaseTaskListId: firebaseTaskListId,
            ),
          ),
        ],
      ),
    );
  }
}


