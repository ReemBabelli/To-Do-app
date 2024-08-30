import 'package:appwrite/appwrite.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/main.dart';

Client client = Client();

void main() {
  client
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('6526af23c9e5afd54062')
      .setSelfSigned(status: true);

  group('',(){
    test('', () async {
      final databases = Databases(client);
      final document = await databases.createDocument(
          databaseId: '6526bcf9dc82afeb08da',
          collectionId: '6542753978ca3cb97917',
          documentId: ID.unique(),
          data: {'categoryName': 'nn'});
      print(document.data);
      expect(document.data.isEmpty, false);
    });
  }

  );
}