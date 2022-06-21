

import 'dart:convert';

Map<String, bool> keyHomeFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, bool>(k, v));

String keyHomeToJson(Map<String, bool> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)));
