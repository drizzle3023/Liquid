
import 'package:liquid/models/MainCategory.dart';
import 'package:liquid/models/SubCategory.dart';

class Venue {
  String venueId;
  String about;
  String address1;
  String address2;
  String address3;
  MainCategory mainCategory;
  String city;
  String country;
  dynamic dateTime;
  String discountBeverages;
  String discountFood;
  String discountOther;
  String discountTerms;
  String email;
  String facebookUrl;
  String image1;
  String image2;
  String image3;
  String image4;
  String image5;
  String instagramUrl;
  String ipAddress;
  bool isActive;
  String latitude;
  String longitude;
  String logoImage;
  String mainImage;
  String name;
  String openingHours;
  String phone;
  String redeem_pincode;
  SubCategory subCategory;
  String twitterUrl;
  String website;
  String youtubeUrl;
  String zip;
  double distance;

  Venue({
    this.venueId,
    this.about,
    this.address1,
    this.address2,
    this.address3,
    this.mainCategory,
    this.city,
    this.country,
    this.dateTime,
    this.discountBeverages,
    this.discountFood,
    this.discountOther,
    this.discountTerms,
    this.email,
    this.facebookUrl,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.instagramUrl,
    this.ipAddress,
    this.isActive,
    this.latitude,
    this.longitude,
    this.logoImage,
    this.mainImage,
    this.name,
    this.openingHours,
    this.phone,
    this.redeem_pincode,
    this.subCategory,
    this.twitterUrl,
    this.website,
    this.youtubeUrl,
    this.zip,
    this.distance
  });

  Map<String, Object> toJson() {
    return {
      'venueId' : venueId == null ? '' : venueId,
      'about' : about == null ? '' : about,
      'address1' : address1 == null ? '' : address1,
      'address2' : address2 == null ? '' : address2,
      'address3' : address3 == null ? '' : address3,
      'category' : mainCategory == null ? '' : mainCategory.toJson(),
      'city' : city == null ? '' : city,
      'country' : country == null ? '' : country,
      'dateTime' : dateTime == null ? '' : dateTime,
      'discountBeverages' : discountBeverages == null ? '' : discountBeverages,
      'discountFood' : discountFood == null ? '' : discountFood,
      'discountOther' : discountOther == null ? '' : discountOther,
      'discountTerms' : discountTerms == null ? '' : discountTerms,
      'email' : email == null ? '' : email,
      'facebookUrl' : facebookUrl == null ? '' : facebookUrl,
      'image1' : image1 == null ? '' : image1,
      'image2' : image2 == null ? '' : image2,
      'image3' : image3 == null ? '' : image3,
      'image4' : image4 == null ? '' : image4,
      'image5' : image5 == null ? '' : image5,
      'instagramUrl' : instagramUrl == null ? '' : instagramUrl,
      'ipAddress' : ipAddress == null ? '' : ipAddress,
      'isActive' : isActive == null ? false : isActive,
      'latitude' : latitude == null ? '' : latitude,
      'longitude' : longitude == null ? '' : longitude,
      'logoImage' : logoImage == null ? '' : logoImage,
      'mainImage' : mainImage == null ? '' : mainImage,
      'name' : name == null ? '' : name,
      'openingHours' : openingHours == null ? '' : openingHours,
      'phone' : phone == null ? '' : phone,
      'redeem_pincode' : redeem_pincode == null ? '' : redeem_pincode,
      'subCategory' : subCategory == null ? '' : subCategory.toJson(),
      'twitterUrl' : twitterUrl == null ? '' : twitterUrl,
      'website' : website == null ? '' : website,
      'youtubeUrl' : youtubeUrl == null ? '' : youtubeUrl,
      'zip' : zip == null ? '' : zip,
      'distance' : distance == null ? 0.toDouble() : distance,
    };
  }

  factory Venue.fromJson(Map<dynamic, dynamic> doc) {
    Venue venue = new Venue(
      venueId : doc['venueId'],
      about : doc['about'],
      address1 : doc['address1'],
      address2 : doc['address2'],
      address3 : doc['address3'],
      mainCategory : MainCategory.fromJson(doc['category']),
      city : doc['city'],
      country : doc['country'],
      dateTime : doc['dateTime'],
      discountBeverages : doc['discountBeverages'],
      discountFood : doc['discountFood'],
      discountOther : doc['discountOther'],
      discountTerms : doc['discountTerms'],
      email : doc['email'],
      facebookUrl : doc['facebookUrl'],
      image1 : doc['image1'],
      image2 : doc['image2'],
      image3 : doc['image3'],
      image4 : doc['image4'],
      image5 : doc['image5'],
      instagramUrl : doc['instagramUrl'],
      ipAddress : doc['ipAddress'],
      isActive : doc['isActive'],
      latitude : doc['latitude'],
      longitude : doc['longitude'],
      logoImage : doc['logoImage'],
      mainImage : doc['mainImage'],
      name : doc['name'],
      openingHours : doc['openingHours'],
      phone : doc['phone'],
      redeem_pincode : doc['redeem_pincode'],
      subCategory : SubCategory.fromJson(doc['subCategory']),
      twitterUrl : doc['twitterUrl'],
      website : doc['website'],
      youtubeUrl : doc['youtubeUrl'],
      zip : doc['zip'],
      distance : doc['distance'] == null ? 0.toDouble() : double.parse(doc['distance'].toString()),

    );
    return venue;
  }

}