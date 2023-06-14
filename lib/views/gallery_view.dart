import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:visions/components/gallery_item.dart';
import 'package:visions/constants/credentials.dart';
import 'package:visions/utils/cloudinary_image.dart';


class GalleryView extends StatelessWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery"),
      ),
      body: showWidget(context),
    );
  }

  showWidget(BuildContext context) {
    return StreamBuilder(
        stream: loadData(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
            default:
              if (snapshot.hasData) {
                final allImages = snapshot.data as List<CloudinaryImage>;
                // return Text("data");
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: allImages.length,
                  itemBuilder: (context, index) {
                    final image = allImages[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: GalleryItem(publicId: image.publicId),
                      ),
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
          }
        });
  }

  Stream<Iterable> loadData() async* {
    // Set the request URL
    String url = 'https://'+ApiKey+':'+ApiSecret+'@api.cloudinary.com/v1_1/'+CloudName+'/resources/search';

    // Set the request headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    // Set the request body
    String requestBody = '''
    {
      "expression": "folder:flutter_cloudinary",
      "sort_by": [{"public_id": "desc"}],
      "max_results": 30
    }
  ''';

    // Make the HTTP POST request
    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: requestBody,
    );

    // Handle the response
    if (response.statusCode == 200) {
      // Request successful
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> resources = CloudinaryImage.parseCloudinaryImages(response.body);
      // List<dynamic> resources = data['resources'];
      yield resources;
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode} because ${response.body}');
    }
  }
}
