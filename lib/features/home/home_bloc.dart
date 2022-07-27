import 'dart:convert';

import 'package:core_advn/common/base_response.dart';
import 'package:core_advn/common/core_constants.dart';
import 'package:http/http.dart' as http;
import 'package:core_advn/common/base_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_dev/common/model/weather.dart';

import '../../common/constants.dart';

class ChangeScrollHomeState extends BaseState {
  final bool expand;

  const ChangeScrollHomeState(this.expand);
}

class ChangeIndexHomeState extends BaseState {
  final int id;

  const ChangeIndexHomeState(this.id);
}

class ChangeSortHomeState extends BaseState {
  final String sort;

  const ChangeSortHomeState(this.sort);
}

class GetValueWeatherEvent extends BaseEvent {
  final String lat;
  final String lon;

  const GetValueWeatherEvent(this.lon, this.lat);
}

class GetValueWeatherState extends BaseState {
  final Weather data;

  const GetValueWeatherState(this.data);
}

class LoadPageHomeState extends BaseState {}

class ChangeScrollHomeEvent extends BaseEvent {
  final bool expand;

  const ChangeScrollHomeEvent(this.expand);
}

class LoadTotalHomeState extends BaseState {
  final int total;
  const LoadTotalHomeState(this.total);
}

class CountNotificationHomeState extends BaseState {
  final int count;
  const CountNotificationHomeState(this.count);
}



class ChangeIndexHomeEvent extends BaseEvent {
  final int id;
  ChangeIndexHomeEvent(this.id);
}

class ChangeSortHomeEvent extends BaseEvent {
  final String sort;
  const ChangeSortHomeEvent(this.sort);
}



class CountCartHomeEvent extends BaseEvent {}

class CountNotificationHomeEvent extends BaseEvent {
  final int count;
  const CountNotificationHomeEvent(this.count);
}

class LoadPageHomeEvent extends BaseEvent {}

class LoadCataloguesHomeEvent extends BaseEvent {}

class LoadTotalHomeEvent extends BaseEvent {
  final int catalogueId;
  final String sortType;
  const LoadTotalHomeEvent(this.sortType, this.catalogueId);
}

class LoadSubCataloguesHomeEvent extends BaseEvent {
  final int catalogueId;
  const LoadSubCataloguesHomeEvent(this.catalogueId);
}

class HomeBloc extends BaseBloc {
  HomeBloc() {
    on<ChangeScrollHomeEvent>(
        (event, emit) => emit(ChangeScrollHomeState(event.expand)));
    on<ChangeIndexHomeEvent>(
        (event, emit) => emit(ChangeIndexHomeState(event.id)));
    on<ChangeSortHomeEvent>(
        (event, emit) => emit(ChangeSortHomeState(event.sort)));
    on<LoadPageHomeEvent>((event, emit) => emit(LoadPageHomeState()));

    on<CountNotificationHomeEvent>(
        (event, emit) => emit(CountNotificationHomeState(event.count)));

    on<GetValueWeatherEvent>((event, emit) async {
      final data = await GetValueWeather(event.lat, event.lon);
      emit(GetValueWeatherState(data));
    });
    // on<CountCartHomeEvent>((event, emit) async {
    //   final count = await Util.countCart();
    //   emit(CountCartState(count));
    // });
    // on<LoadCataloguesHomeEvent>((event, emit) async {
    //   final response = await ApiClient().getAPI('${Constants.apiVersion}catalogues', CataloguesModel(), hasHeader: false);
    //   emit(LoadCataloguesHomeState(response));
    // });
    // on<LoadTotalHomeEvent>((event, emit) async {
    //   String catalogue = '';
    //   if(event.catalogueId > 0) catalogue = 'catalogue_ids=${event.catalogueId}&';
    //   String sortType = '';
    //   if(event.sortType.isNotEmpty) sortType = 'sort_type=${event.sortType}&is_home=1&';
    //   final response = await ApiClient().getAPI('${Constants.apiVersion}products/get_total_product?$catalogue$sortType', TotalModel(), hasHeader: false);
    //   int total = 0;
    //   if(!response.checkTimeout() && response.checkOK()) total = response.data.total_product;
    //   emit(LoadTotalHomeState(total));
    // });
    // on<LoadSubCataloguesHomeEvent>((event, emit) async {
    //   final response = await ApiClient().getAPI('${Constants.apiVersion}catalogues/'
    //       '${event.catalogueId}/children', SubCataloguesModel(), hasHeader: false);
    //   emit(LoadSubCataloguesHomeState(response));
    // });
  }
}
// Future<BaseResponse> getAPI(String path, data, {bool hasHeader = true, bool hasDomain = true}) async {
//   final baseResponse = BaseResponse();
//   try {
//     http.Response response;
//     final prefs = await SharedPreferences.getInstance();
//     if (hasHeader && prefs.containsKey(Constants.isLogin) &&
//         prefs.getBool(Constants.isLogin)!) {
//       response = await httpClient.get(Uri.parse(Constants.baseUrl + path),
//           headers: await _getHeader()).timeout(const Duration(seconds: 20));
//     } else {
//       response = await httpClient.get(Uri.parse((hasDomain ? Constants.baseUrl : '') + path))
//           .timeout(const Duration(seconds: 20));
//     }
//     baseResponse.fromJson(jsonDecode(response.body), data);
//   } catch (e) {
//
//   }
//   return baseResponse;
// }

Future GetValueWeather(String lat, String lon) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  };
  String filurl =
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=5383ac85ab5fa5d68cc5dc2906229284&lang=${CoreConstants.localeLang}';
  try {
    Weather data;
    http.Response response =
        await http.Client().get(Uri.parse(filurl), headers: headers);
    print(response);
    // var respon = json.decode(response.toString());
    data = weatherFromJson(response.body);
    return data;
  } catch (e) {
    // ignore: avoid_print
    print('Server Handler : error : ' + e.toString());
    rethrow;
  }
}