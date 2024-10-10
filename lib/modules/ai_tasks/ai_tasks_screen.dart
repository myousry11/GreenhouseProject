import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled6/modules/ai_tasks/ClassificationDTO.dart';
import 'package:untitled6/shared/components/constants.dart';

Future<ClassificationDto> fetchClassificationData() async {
  final Uri url = Uri.parse(Constants.classification);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return ClassificationDto.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class ImageClassifier extends StatefulWidget {
  @override
  State<ImageClassifier> createState() => _ImageClassifierState();
}

class _ImageClassifierState extends State<ImageClassifier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<ClassificationDto>(
          future: fetchClassificationData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              var result = snapshot.data;
              return RefreshIndicator(
                onRefresh: () async {
                  fetchClassificationData();
                  setState(() {});
                },
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: [
                    Image.memory(
                      Base64Decoder().convert(result?.imageName ?? ""),
                      height: 400,
                      width: 200,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ...result?.classificationResults?.map((classification) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  'Disease: ${classification.diseaseName}',
                                style: TextStyle(
                                    fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                            ],
                          );
                        }).toList() ?? [],
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/error.png',
                    height: 400,
                    width: 400,
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.bottomCenter,
                      child: Text(
                          'Error: ${snapshot.error }',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                  ),
                ],
              );
            } else {
              return Text('No data available');
            }
          },
        ),
      ),
    );
  }
}
