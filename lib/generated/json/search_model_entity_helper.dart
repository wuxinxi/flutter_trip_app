import 'package:trip/model/search_model_entity.dart';

searchModelEntityFromJson(SearchModelEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<SearchModelData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new SearchModelData().fromJson(v));
		});
	}
	if (json['total'] != null) {
		data.total = json['total']?.toInt();
	}
	if (json['head'] != null) {
		data.head = new SearchModelHead().fromJson(json['head']);
	}
	if (json['highLights'] != null) {
		data.highLights = new List<dynamic>();
		data.highLights.addAll(json['highLights']);
	}
	if (json['resultTypes'] != null) {
		data.resultTypes = new List<dynamic>();
		data.resultTypes.addAll(json['resultTypes']);
	}
	if (json['isLastPage'] != null) {
		data.isLastPage = json['isLastPage'];
	}
	if (json['subResultTypes'] != null) {
		data.subResultTypes = new List<dynamic>();
		data.subResultTypes.addAll(json['subResultTypes']);
	}
	return data;
}

Map<String, dynamic> searchModelEntityToJson(SearchModelEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['total'] = entity.total;
	if (entity.head != null) {
		data['head'] = entity.head.toJson();
	}
	if (entity.highLights != null) {
		data['highLights'] =  [];
	}
	if (entity.resultTypes != null) {
		data['resultTypes'] =  [];
	}
	data['isLastPage'] = entity.isLastPage;
	if (entity.subResultTypes != null) {
		data['subResultTypes'] =  [];
	}
	return data;
}

searchModelDataFromJson(SearchModelData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['word'] != null) {
		data.word = json['word']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toString();
	}
	if (json['url'] != null) {
		data.url = json['url']?.toString();
	}
	if (json['lat'] != null) {
		data.lat = json['lat']?.toInt();
	}
	if (json['lon'] != null) {
		data.lon = json['lon']?.toInt();
	}
	if (json['cityId'] != null) {
		data.cityId = json['cityId']?.toInt();
	}
	if (json['districtId'] != null) {
		data.districtId = json['districtId']?.toInt();
	}
	if (json['productScore'] != null) {
		data.productScore = json['productScore']?.toInt();
	}
	if (json['scoreDesc'] != null) {
		data.scoreDesc = json['scoreDesc']?.toString();
	}
	if (json['childProductScore'] != null) {
		data.childProductScore = json['childProductScore']?.toInt();
	}
	if (json['childScoreDesc'] != null) {
		data.childScoreDesc = json['childScoreDesc']?.toString();
	}
	if (json['simNum'] != null) {
		data.simNum = json['simNum']?.toInt();
	}
	if (json['luceneScore'] != null) {
		data.luceneScore = json['luceneScore']?.toInt();
	}
	if (json['commentCount'] != null) {
		data.commentCount = json['commentCount']?.toInt();
	}
	if (json['commentScore'] != null) {
		data.commentScore = json['commentScore']?.toInt();
	}
	if (json['sales'] != null) {
		data.sales = json['sales']?.toInt();
	}
	if (json['startScore'] != null) {
		data.startScore = json['startScore']?.toInt();
	}
	if (json['parentDistrictId'] != null) {
		data.parentDistrictId = json['parentDistrictId']?.toInt();
	}
	if (json['traveldays'] != null) {
		data.traveldays = json['traveldays']?.toInt();
	}
	if (json['districtname'] != null) {
		data.districtname = json['districtname']?.toString();
	}
	if (json['price'] != null) {
		data.price = json['price']?.toString();
	}
	return data;
}

Map<String, dynamic> searchModelDataToJson(SearchModelData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['word'] = entity.word;
	data['type'] = entity.type;
	data['url'] = entity.url;
	data['lat'] = entity.lat;
	data['lon'] = entity.lon;
	data['cityId'] = entity.cityId;
	data['districtId'] = entity.districtId;
	data['productScore'] = entity.productScore;
	data['scoreDesc'] = entity.scoreDesc;
	data['childProductScore'] = entity.childProductScore;
	data['childScoreDesc'] = entity.childScoreDesc;
	data['simNum'] = entity.simNum;
	data['luceneScore'] = entity.luceneScore;
	data['commentCount'] = entity.commentCount;
	data['commentScore'] = entity.commentScore;
	data['sales'] = entity.sales;
	data['startScore'] = entity.startScore;
	data['parentDistrictId'] = entity.parentDistrictId;
	data['traveldays'] = entity.traveldays;
	data['districtname'] = entity.districtname;
	data['price'] = entity.price;
	return data;
}

searchModelHeadFromJson(SearchModelHead data, Map<String, dynamic> json) {
	return data;
}

Map<String, dynamic> searchModelHeadToJson(SearchModelHead entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	return data;
}