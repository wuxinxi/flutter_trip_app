import 'package:trip/generated/json/base/json_convert_content.dart';

class SearchModelEntity with JsonConvert<SearchModelEntity> {
	List<SearchModelData> data;
	int total;
	SearchModelHead head;
	List<dynamic> highLights;
	List<dynamic> resultTypes;
	bool isLastPage;
	List<dynamic> subResultTypes;
}

class SearchModelData with JsonConvert<SearchModelData> {
	int id;
	String word;
	String type;
	String url;
	int lat;
	int lon;
	int cityId;
	int districtId;
	int productScore;
	String scoreDesc;
	int childProductScore;
	String childScoreDesc;
	int simNum;
	int luceneScore;
	int commentCount;
	int commentScore;
	int sales;
	int startScore;
	int parentDistrictId;
	int traveldays;
	String districtName;
}

class SearchModelHead with JsonConvert<SearchModelHead> {

}
