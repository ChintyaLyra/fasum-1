import 'package:firebase_database/firebase_database.dart';

class PostService{
  final DatabaseReference _database =
  FirebaseDatabase.instance.ref().child('post_list');

  Stream<Map<String, String>> getPostList(){
    return _database.onValue.map((event){
      final Map<String, String> items = {};
      DataSnapshot snapshot =event.snapshot;
      if(snapshot.value != null){
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          items[key] =
          'Kode Produk: ${value['kode']} \nDeskripsi: ${value['deskripsi']}';
        });
      }
      return items;
    });
  }
  void addPostItem(String itemKode, String itemDeskripsi){
    _database.push().set({
      'kode': itemKode,
      'deskripsi': itemDeskripsi
    });
  }
  Future<void> removeProductItem(String key) async{
    await _database.child(key).remove();
  }
}