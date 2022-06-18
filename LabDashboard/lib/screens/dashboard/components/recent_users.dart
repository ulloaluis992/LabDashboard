import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/models/user_model.dart';
import 'package:smart_admin_dashboard/services/firebase_service.dart';

class RecentUsers extends StatefulWidget {
  RecentUsers({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentUsers> createState() => _RecentUsersState();
}

class _RecentUsersState extends State<RecentUsers> {
  late UserService userService;
  late List<UserModel> listUser = [];

  @override
  void initState() {
    userService = new UserService();
    _getUsers();

    super.initState();
  }

  _getUsers() async {
    var result = await userService.getUsers();
    setState(() {
      listUser = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Users",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                horizontalMargin: 0,
                columnSpacing: defaultPadding,
                columns: [
                  DataColumn(
                    label: Text("nombre"),
                  ),
                  DataColumn(
                    label: Text("apellido"),
                  ),
                  DataColumn(
                    label: Text("email"),
                  ),
                  DataColumn(
                    label: Text("password"),
                  ),
                  DataColumn(
                    label: Text("role"),
                  ),
                  DataColumn(
                    label: Text("botones"),
                  ),
                ],
                rows: List.generate(
                  listUser.length,
                  (index) {
                    if (listUser[index].id.isNotEmpty) {
                      return recentUserDataRow(listUser[index], context);
                    } else {
                      return DataRow(cells: []);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow recentUserDataRow(UserModel userInfo, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              TextAvatar(
                size: 35,
                backgroundColor: Colors.white,
                textColor: Colors.white,
                fontSize: 14,
                upperCase: true,
                numberLetters: 1,
                shape: Shape.Rectangle,
                text: userInfo.name,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                  '${userInfo.name} ${userInfo.lastName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(userInfo.lastName.toString())),
        DataCell(Text(userInfo.email.toString())),
        DataCell(Text(userInfo.password.toString())),
        DataCell(Text(userInfo.role.toString())),
        DataCell(
          Row(
            children: [
              SizedBox(
                width: 6,
              ),
              SizedBox(
                width: 6,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red.withOpacity(0.5),
                ),
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Center(
                            child: Text("Confirmar"),
                          ),
                          content: Container(
                            color: secondaryColor,
                            height: 70,
                            child: Column(
                              children: [
                                Text(
                                    "Esta seguro de eliminar '${userInfo.name}'?"),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                        icon: Icon(
                                          Icons.close,
                                          size: 14,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.grey),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        label: Text("Cancelar")),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton.icon(
                                      icon: Icon(
                                        Icons.delete,
                                        size: 14,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                      onPressed: () async {},
                                      label: Text("Eliminar"),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                // Delete
                label: Text("Delete"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
