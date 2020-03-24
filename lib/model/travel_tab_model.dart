/// url : "https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5"
/// params : {"districtId":-1,"groupChannelCode":"tourphoto_global1","type":null,"lat":-180,"lon":-180,"locatedDistrictId":2,"pagePara":{"pageIndex":1,"pageSize":10,"sortType":9,"sortDirection":0},"imageCutType":1,"head":{"cid":"09031014111431397988","ctok":"","cver":"1.0","lang":"01","sid":"8888","syscode":"09","auth":null,"extension":[{"name":"protocal","value":"https"}]},"contentType":"json"}
/// tabs : [{"labelName":"推荐","groupChannelCode":"tourphoto_global1"},{"labelName":"端午去哪玩","groupChannelCode":"tab-dwqnw"},{"labelName":"权力的游戏","groupChannelCode":"quanliyouxi"},{"labelName":"创造营2019","groupChannelCode":"chuangzaoyingchaohua"},{"labelName":"比心地球","groupChannelCode":"ycy422"},{"labelName":"拍照技巧","groupChannelCode":"tab-photo"}]

class TravelTabModel {
  String url;
  List<Tabs> tabs;

  TravelTabModel({this.url, this.tabs});

  TravelTabModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    if (json['tabs'] != null) {
      tabs = new List<Tabs>();
      json['tabs'].forEach((v) {
        tabs.add(new Tabs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    if (this.tabs != null) {
      data['tabs'] = this.tabs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tabs {
  String labelName;
  String groupChannelCode;

  Tabs({this.labelName, this.groupChannelCode});

  Tabs.fromJson(Map<String, dynamic> json) {
    labelName = json['labelName'];
    groupChannelCode = json['groupChannelCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labelName'] = this.labelName;
    data['groupChannelCode'] = this.groupChannelCode;
    return data;
  }
}
