


import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/features/main/main_bloc.dart';
import 'package:smart_home_dev/features/main/ui/drawer_content.dart';

import '../../../common/ui/base_page_state.dart';

class MainPageUI extends StatelessWidget {
  static int index = 0;
  // final UserModel user;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final MainBloc bloc;
  final Function changePage, getPage;

  const MainPageUI(this.scaffoldKey, this.bloc, this.changePage, this.getPage, {Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: scaffoldKey, drawer:
    Drawer(child: DrawerContent(bloc, changePage)),
        body: BlocBuilder(bloc: bloc, builder: (context, state) => getPage(),
            buildWhen: (oldState, newState) => newState is ChangePageMainState));

  }
}
