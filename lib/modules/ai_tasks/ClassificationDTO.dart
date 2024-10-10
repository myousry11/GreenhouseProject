class ClassificationDto {
  List<ClassificationResults>? classificationResults;
  String? imageName;

  ClassificationDto({
    this.classificationResults,
    this.imageName,
  });

  ClassificationDto.fromJson(dynamic json) {
    if (json['classificationResults'] != null) {
      classificationResults = [];
      // Use firstWhere to get the first valid diseaseName
      var firstValidResult = json['classificationResults'].firstWhere(
            (result) => result['disease_name'] != null,
        orElse: () => null,
      );
      if (firstValidResult != null) {
        classificationResults?.add(ClassificationResults.fromJson(firstValidResult));
      }
    }
    imageName = json['imageName'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (classificationResults != null) {
      map['classificationResults'] = classificationResults?.map((v) => v.toJson()).toList();
    }
    map['imageName'] = imageName;
    return map;
  }
}

class ClassificationResults {
  String? diseaseName;
  num? confidence;
  List<num>? boundingBox;

  ClassificationResults({
    this.diseaseName,
    this.confidence,
    this.boundingBox,
  });

  ClassificationResults.fromJson(dynamic json) {
    diseaseName = json['disease_name'];
    confidence = json['confidence'];
    boundingBox = json['bounding_box'] != null ? json['bounding_box'].cast<num>() : [];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['disease_name'] = diseaseName;
    map['confidence'] = confidence;
    map['bounding_box'] = boundingBox;
    return map;
  }
}
