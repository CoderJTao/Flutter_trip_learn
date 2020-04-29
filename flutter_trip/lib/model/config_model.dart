/**
 *
    字段 | 类型 | 备注
    | -------- | -------- | -------- |
    searchUrl | String	| NonNull
 */


class ConfigModel {
  final String searchUrl;

  ConfigModel({this.searchUrl});

  factory ConfigModel.fromJson(Map<String, dynamic>json) {
    return ConfigModel(
      searchUrl: json['searchUrl']
    );
  }

  Map<String, dynamic> toJson() {
    return {"searchUrl": searchUrl};
  }
}