import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/routes/routesname.dart';
import 'package:firebase/view/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireStore extends StatefulWidget {
  const FireStore({Key? key}) : super(key: key);

  @override
  State<FireStore> createState() => _FireStoreState();
}

class _FireStoreState extends State<FireStore> {
  var edit = TextEditingController();
  var auth = FirebaseAuth.instance;
  var fireStore = FirebaseFirestore.instance.collection('usama').snapshots();
  var colection = FirebaseFirestore.instance.collection('usama');
  var search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FireStore List'),
        centerTitle: true,
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
          SizedBox(height: 20),
          TextFormField(
            controller: search,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Search'),
            onChanged: (_) {
              setState(() {});
            },
          ),
          StreamBuilder(
            stream: fireStore,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) return const Text('Some error');

              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final title =
                        snapshot.data!.docs[index]['title'].toString();
                    if (search.text.isEmpty) {
                      return ListTile(
                        title: Text(
                            snapshot.data!.docs[index]['title'].toString()),
                        subtitle:
                            Text(snapshot.data!.docs[index].id.toString()),
                        trailing: PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  showDailogBox(
                                      snapshot.data!.docs[index]['title']
                                          .toString(),
                                      snapshot.data!.docs[index].id.toString());
                                },
                                title: const Text('Edit'),
                                leading: const Icon(Icons.edit),
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  colection
                                      .doc(snapshot.data!.docs[index].id
                                          .toString())
                                      .delete();
                                },
                                title: const Text('Delete'),
                                leading:
                                    const Icon(Icons.delete_forever_outlined),
                              ),
                            )
                          ],
                        ),
                      );
                    } else if (title
                        .toLowerCase()
                        .contains(search.text.toString().toLowerCase())) {
                      return ListTile(
                        title: Text(
                            snapshot.data!.docs[index]['title'].toString()),
                        subtitle:
                            Text(snapshot.data!.docs[index].id.toString()),
                        trailing: PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  showDailogBox(
                                      snapshot.data!.docs[index]['title']
                                          .toString(),
                                      snapshot.data!.docs[index].id.toString());
                                },
                                title: const Text('Edit'),
                                leading: const Icon(Icons.edit),
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  colection
                                      .doc(snapshot.data!.docs[index].id
                                          .toString())
                                      .delete()
                                      .then((value) {
                                    Utils().toastMessage('Deleted');
                                  }).onError((error, stackTrace) {
                                    Utils().toastMessage(error.toString());
                                  });
                                },
                                title: const Text('Delete'),
                                leading:
                                    const Icon(Icons.delete_forever_outlined),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.addfirestore);
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
                colection
                    .doc(id.toString())
                    .update({'title': edit.text.toString()}).then((value) {
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
