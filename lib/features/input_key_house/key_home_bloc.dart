
import 'package:http/http.dart' as http;
import 'package:core_advn/common/base_bloc.dart';
import 'package:smart_home_dev/common/model/keyhome.dart';

class GetKeyHomeEvent extends BaseEvent {
}

class GetKeyHomeState extends BaseState {
  final Map<String, bool> data;
  const GetKeyHomeState(this.data);
}


class InputKeyHomeBloc extends BaseBloc {
  InputKeyHomeBloc(){
    on<GetKeyHomeEvent>((event, emit) async {
      final data = await GetValueWeather();
      emit(GetKeyHomeState(data));
    });
  }
}
Future GetValueWeather() async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  };
  String filurl =
      'https://smarthomefinal-b925f-default-rtdb.firebaseio.com/smart_home.json?shallow=true';
  try {
    Map<String, bool> data;
    http.Response response =
    await http.Client().get(Uri.parse(filurl), headers: headers);
    print(response);
    data = keyHomeFromJson(response.body);
    return data;
  } catch (e) {
    // ignore: avoid_print
    print('Server Handler : error : ' + e.toString());
    rethrow;
  }
}