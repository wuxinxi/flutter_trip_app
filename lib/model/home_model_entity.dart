import 'package:trip/generated/json/base/json_convert_content.dart';

class HomeModelEntity with JsonConvert<HomeModelEntity> {
	HomeModelConfig config;
	List<HomeModelBannerList> bannerList;
	List<HomeModelLocalNavList> localNavList;
	HomeModelGridNav gridNav;
	List<HomeModelSubNavList> subNavList;
	HomeModelSalesBox salesBox;
}

class HomeModelConfig with JsonConvert<HomeModelConfig> {
	String searchUrl;
}

class HomeModelBannerList with JsonConvert<HomeModelBannerList> {
	String icon;
	String url;
}

class HomeModelLocalNavList with JsonConvert<HomeModelLocalNavList> {
	String icon;
	String title;
	String url;
	String statusBarColor;
	bool hideAppBar;
}

class HomeModelGridNav with JsonConvert<HomeModelGridNav> {
	HomeModelGridNavHotel hotel;
	HomeModelGridNavFlight flight;
	HomeModelGridNavTravel travel;
}

class HomeModelGridNavHotel with JsonConvert<HomeModelGridNavHotel> {
	String startColor;
	String endColor;
	HomeModelGridNavHotelMainItem mainItem;
	HomeModelGridNavHotelItem1 item1;
	HomeModelGridNavHotelItem2 item2;
	HomeModelGridNavHotelItem3 item3;
	HomeModelGridNavHotelItem4 item4;
}

class HomeModelGridNavHotelMainItem with JsonConvert<HomeModelGridNavHotelMainItem> {
	String title;
	String icon;
	String url;
	String statusBarColor;
}

class HomeModelGridNavHotelItem1 with JsonConvert<HomeModelGridNavHotelItem1> {
	String title;
	String url;
	String statusBarColor;
}

class HomeModelGridNavHotelItem2 with JsonConvert<HomeModelGridNavHotelItem2> {
	String title;
	String url;
}

class HomeModelGridNavHotelItem3 with JsonConvert<HomeModelGridNavHotelItem3> {
	String title;
	String url;
	bool hideAppBar;
}

class HomeModelGridNavHotelItem4 with JsonConvert<HomeModelGridNavHotelItem4> {
	String title;
	String url;
	bool hideAppBar;
}

class HomeModelGridNavFlight with JsonConvert<HomeModelGridNavFlight> {
	String startColor;
	String endColor;
	HomeModelGridNavFlightMainItem mainItem;
	HomeModelGridNavFlightItem1 item1;
	HomeModelGridNavFlightItem2 item2;
	HomeModelGridNavFlightItem3 item3;
	HomeModelGridNavFlightItem4 item4;

	@override
	String toString() {
		return 'HomeModelGridNavFlight{startColor: $startColor, endColor: $endColor, mainItem: $mainItem, item1: $item1, item2: $item2, item3: $item3, item4: $item4}';
	}

}

class HomeModelGridNavFlightMainItem with JsonConvert<HomeModelGridNavFlightMainItem> {
	String title;
	String icon;
	String url;
}

class HomeModelGridNavFlightItem1 with JsonConvert<HomeModelGridNavFlightItem1> {
	String title;
	String url;
	bool hideAppBar;
}

class HomeModelGridNavFlightItem2 with JsonConvert<HomeModelGridNavFlightItem2> {
	String title;
	String url;
}

class HomeModelGridNavFlightItem3 with JsonConvert<HomeModelGridNavFlightItem3> {
	String title;
	String url;
	bool hideAppBar;
}

class HomeModelGridNavFlightItem4 with JsonConvert<HomeModelGridNavFlightItem4> {
	String title;
	String url;
	bool hideAppBar;
}

class HomeModelGridNavTravel with JsonConvert<HomeModelGridNavTravel> {
	String startColor;
	String endColor;
	HomeModelGridNavTravelMainItem mainItem;
	HomeModelGridNavTravelItem1 item1;
	HomeModelGridNavTravelItem2 item2;
	HomeModelGridNavTravelItem3 item3;
	HomeModelGridNavTravelItem4 item4;
}

class HomeModelGridNavTravelMainItem with JsonConvert<HomeModelGridNavTravelMainItem> {
	String title;
	String icon;
	String url;
	bool hideAppBar;
	String statusBarColor;
}

class HomeModelGridNavTravelItem1 with JsonConvert<HomeModelGridNavTravelItem1> {
	String title;
	String url;
	String statusBarColor;
	bool hideAppBar;
}

class HomeModelGridNavTravelItem2 with JsonConvert<HomeModelGridNavTravelItem2> {
	String title;
	String url;
	String statusBarColor;
	bool hideAppBar;
}

class HomeModelGridNavTravelItem3 with JsonConvert<HomeModelGridNavTravelItem3> {
	String title;
	String url;
	bool hideAppBar;
}

class HomeModelGridNavTravelItem4 with JsonConvert<HomeModelGridNavTravelItem4> {
	String title;
	String url;
	bool hideAppBar;
}

class HomeModelSubNavList with JsonConvert<HomeModelSubNavList> {
	String icon;
	String title;
	String url;
	bool hideAppBar;
}

class HomeModelSalesBox with JsonConvert<HomeModelSalesBox> {
	String icon;
	String moreUrl;
	HomeModelSalesBoxBigCard1 bigCard1;
	HomeModelSalesBoxBigCard2 bigCard2;
	HomeModelSalesBoxSmallCard1 smallCard1;
	HomeModelSalesBoxSmallCard2 smallCard2;
	HomeModelSalesBoxSmallCard3 smallCard3;
	HomeModelSalesBoxSmallCard4 smallCard4;
}

class HomeModelSalesBoxBigCard1 with JsonConvert<HomeModelSalesBoxBigCard1> {
	String icon;
	String url;
	String title;
}

class HomeModelSalesBoxBigCard2 with JsonConvert<HomeModelSalesBoxBigCard2> {
	String icon;
	String url;
	String title;
}

class HomeModelSalesBoxSmallCard1 with JsonConvert<HomeModelSalesBoxSmallCard1> {
	String icon;
	String url;
	String title;
}

class HomeModelSalesBoxSmallCard2 with JsonConvert<HomeModelSalesBoxSmallCard2> {
	String icon;
	String url;
	String title;
}

class HomeModelSalesBoxSmallCard3 with JsonConvert<HomeModelSalesBoxSmallCard3> {
	String icon;
	String url;
	String title;
}

class HomeModelSalesBoxSmallCard4 with JsonConvert<HomeModelSalesBoxSmallCard4> {
	String icon;
	String url;
	String title;
}
