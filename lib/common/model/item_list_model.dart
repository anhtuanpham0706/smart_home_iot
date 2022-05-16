import 'package:core_advn/common/utils/core_util.dart';

class ItemListModel {
  final List<ItemModel> list = [];

  ItemListModel fromJson(data) {
    if (data != null && data.isNotEmpty)
      data.forEach((ele) => list.add(ItemModel().fromJson(ele)));
    return this;
  }

  listsToObjects(List<String> listInt, List<String> listStr) {
    if (listInt.length == listStr.length)
      for (int i = 0; i < listInt.length; i++)
        list.add(ItemModel(id: listInt[i], name: listStr[i]));
  }

  List<String> objectsToStrings() {
    final List<String> tmp = [];
    for (var element in list) {
      tmp.add(element.name);
    }
    return tmp;
  }

  List<String> objectsToInts() {
    final List<String> tmp = [];
    for (var element in list) {
      tmp.add(element.id);
    }
    return tmp;
  }
}

class ItemModel {
  String id;
  String name;
  bool select;

  ItemModel({this.id = '', this.name = '', this.select = false});

  ItemModel fromJson(json) {
    id = CoreUtil.getValueFromJson(json, 'id', '');
    name = CoreUtil.getValueFromJson(json, 'name', '');
    return this;
  }

  void copy(ItemModel value) {
    id = value.id;
    name = value.name;
    select = value.select;
  }
}
