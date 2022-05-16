

import 'package:smart_home_dev/features/home/home_bloc.dart';
import 'package:smart_home_dev/features/home/ui/home_page_ui.dart';

import '../../common/ui/base_page_state.dart';

class HomePage extends BasePage {
  final Function funOpenDrawer;


  HomePage(this.funOpenDrawer,
      {Key? key}) : super(_HomePageState(), key:key);
}



class _HomePageState extends BasePageState {




  @override
  Widget build(BuildContext context, {Color color = Colors.white}) =>
      Container(child: HomePageUI( bloc as HomeBloc,
          _menuAction
      ), color: color);



  @override
  Widget createUI(BuildContext context) => const SizedBox();


  @override
  void initBloc() {
    bloc = HomeBloc();

  }

  @override
  void initUI() {
    // TODO: implement initUI
  }
  void _menuAction() => (widget as HomePage).funOpenDrawer();

}