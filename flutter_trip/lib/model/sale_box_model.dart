/**
 *
    字段 | 类型 | 备注
    | -------- | -------- | -------- |
    icon | String	| NonNull
    moreUrl | String	|	NonNull
    bigCard1 | Object	|	NonNull
    bigCard2 | Object	|	NonNull
    smallCard1 | Object	|	NonNull
    smallCard2 | Object	|	NonNull
    smallCard3 | Object	|	NonNull
    smallCard4 | Object	|	NonNull
 */

import 'package:trip/model/common_model.dart';

///活动入口模型
class SaleBoxModel {
  final String icon;
  final String moreUrl;
  final CommonModel bigCard1;
  final CommonModel bigCard2;
  final CommonModel smallCard1;
  final CommonModel smallCard2;
  final CommonModel smallCard3;
  final CommonModel smallCard4;

  SaleBoxModel({
    this.icon,
    this.moreUrl,
    this.bigCard1,
    this.bigCard2,
    this.smallCard1,
    this.smallCard2,
    this.smallCard3,
    this.smallCard4});

  factory SaleBoxModel.fromJson(Map<String, dynamic> json) {
    return SaleBoxModel(
        icon: json['icon'],
        moreUrl: json['moreUrl'],
        bigCard1: CommonModel.fromJson(json['bigCard1']),
        bigCard2: CommonModel.fromJson(json['bigCard2']),
        smallCard1: CommonModel.fromJson(json['smallCard1']),
        smallCard2: CommonModel.fromJson(json['smallCard2']),
        smallCard3: CommonModel.fromJson(json['smallCard3']),
        smallCard4: CommonModel.fromJson(json['smallCard4'])
    );
  }
}



