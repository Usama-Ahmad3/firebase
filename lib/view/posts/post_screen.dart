import 'package:firebase/routes/routesname.dart';
import 'package:firebase/view/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  var ref = FirebaseDatabase.instance.ref('Post');
  var search = TextEditingController();
  var edit = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.pushNamed(context, RoutesName.login);
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: const Icon(Icons.login_outlined)),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: search,
            decoration: const InputDecoration(
                hintText: 'Search', border: OutlineInputBorder()),
            onChanged: (_) {
              setState(() {});
            },
          ),
          Expanded(
            child: FirebaseAnimatedList(
              defaultChild: const Center(
                  child: CircularProgressIndicator(
                strokeWidth: 30,
              )),
              query: ref,
              itemBuilder: ((context, snapshot, animation, index) {
                final title = snapshot.child('title').value.toString();
                if (search.text.isEmpty) {
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                    trailing: PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              showDailogBox(
                                  title, snapshot.child('id').value.toString());
                            },
                            leading: const Icon(Icons.edit),
                            title: const Text('Edit'),
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              ref
                                  .child(snapshot.child('id').value.toString())
                                  .remove();
                            },
                            title: const Text('Delete'),
                            leading: const Icon(Icons.delete_forever_outlined),
                          ),
                        )
                      ],
                    ),
                  );
                } else if (title
                    .toLowerCase()
                    .contains(search.text.toLowerCase().toLowerCase())) {
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                    trailing: PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              showDailogBox(
                                  title, snapshot.child('id').value.toString());
                            },
                            leading: const Icon(Icons.edit),
                            title: const Text('Edit'),
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              ref
                                  .child(snapshot.child('id').value.toString())
                                  .remove();
                            },
                            title: const Text('Delete'),
                            leading: const Icon(Icons.delete_forever_outlined),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              }),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.addPost);
        },
      ),
    );
  }

  Future<void> showDailogBox(String title, String id) async {
    edit.text = title;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update'),
        content: TextField(
          controller: edit,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                ref
                    .child(id)
                    .update({'title': edit.text.toLowerCase()}).then((value) {
                  Utils().toastMessage('Updated');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              child: const Text('Update'))
        ],
      ),
    );
  }
}
// Expanded(
//               child: StreamBuilder(
//             stream: ref.onValue,
//             builder:
//                 (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
//               if (!snapshot.hasData) {
//                 return CircularProgressIndicator();
//               } else {
//                 Map<dynamic, dynamic> map =
//                     snapshot.data!.snapshot.value as dynamic;
//                 List<dynamic> list = [];
//                 list.clear();
//                 list = map.values.toList();
//                 return ListView.builder(
//                   itemCount: snapshot.data!.snapshot.children.length,
//                   itemBuilder: (context, index) => ListTile(
//                     title: Text(list[index]['title']),
//                     subtitle: Text(list[index]['id']),
//                   ),
//                 );
//               }
//             },
//           )),
