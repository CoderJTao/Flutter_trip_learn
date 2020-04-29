import 'package:trip/model/common_model.dart';
/**
 *
    config | Object	| NonNull
    bannerList | Array	|	NonNull
    localNavList | Array	|	NonNull
    gridNav | Object	|	NonNull
    subNavList | Array	|	NonNull
    salesBox | Object	|	NonNull
 */

import 'package:trip/model/config_model.dart';
import 'package:trip/model/grid_nav_model.dart';
import 'package:trip/model/sale_box_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SaleBoxModel salesBox;

  HomeModel({
    this.config,
    this.bannerList,
    this.localNavList,
    this.subNavList,
    this.gridNav,
    this.salesBox,});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
      bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
      localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
      subNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    return HomeModel(
      config: ConfigModel.fromJson(json['config']),
      bannerList: bannerList,
      localNavList: localNavList,
      subNavList: subNavList,
      gridNav: GridNavModel.fromJson(json['gridNav']),
      salesBox: SaleBoxModel.fromJson(json['salesBox'])
    );
  }
}