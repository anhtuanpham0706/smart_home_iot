import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_dev/common/smarthome_style.dart';
import 'package:smart_home_dev/common/ui/image_from_network.dart';
import 'package:smart_home_dev/common/ui/text_custom.dart';

import 'base_page_state.dart';

class SliderImage extends StatefulWidget {
  final List<String> listImage;
  final Alignment align;
  final double? height, radius;
  final double bottom, opacity;
  final Color color, colorPoint;
  final BoxFit fit;
  final bool hasSub, showCount;

  const SliderImage(this.listImage,
      {this.showCount = false,
      this.radius,
      this.hasSub = false,
      this.fit = BoxFit.fill,
      this.bottom = 0.0,
      this.colorPoint = SmartHomeStyle.colorRed,
      this.color = Colors.transparent,
      this.align = Alignment.bottomLeft,
      this.height,
      this.opacity = 1,
      Key? key})
      : super(key: key);

  @override
  _SliderImageState createState() => _SliderImageState();
}

class _SliderImageState extends State<SliderImage> {
  final SliderImageBloc bloc = SliderImageBloc();
  ScrollController? _scroll;
  ScrollController? _scrollSub;

  @override
  void initState() {
    if (!widget.showCount) _scroll = ScrollController();
    if (widget.hasSub) _scrollSub = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scroll?.dispose();
    _scrollSub?.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(children: [
        Stack(alignment: widget.align, children: [
          Container(
              height: widget.height ?? 0.3.sh,
              width: 1.sw,
              decoration: BoxDecoration(
                  color: widget.color,
                  border: Border.all(color: Colors.black12, width: 0.3),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(widget.radius ?? 60.sp))),
              child: widget.listImage.isNotEmpty
                  ? CarouselSlider.builder(
                      itemCount: widget.listImage.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                              int realIndex) =>
                          ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(widget.radius ?? 60.sp)),
                              child: ImageFromNetwork(
                                  widget.listImage[itemIndex],
                                  defaultAsset:
                                      'assets/images/theme3/ic_transparent.png',
                                  height: widget.height ?? 0.3.sh,
                                  width: 1.sw,
                                  fit: widget.fit)),
                      options: CarouselOptions(
                          autoPlay: widget.listImage.length > 1,
                          viewportFraction: 1.0,
                          aspectRatio: 1.0,
                          onPageChanged: (index, status) {
                            if (!widget.showCount && index % 6 == 0) {
                              if (_scroll != null && _scroll!.hasClients)
                                Timer(
                                    const Duration(seconds: 1),
                                    () => _scroll!.animateTo(index * 15.sp,
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.ease));
                              if (widget.hasSub &&
                                  _scrollSub != null &&
                                  _scrollSub!.hasClients)
                                Timer(
                                    const Duration(seconds: 1),
                                    () => _scrollSub!.animateTo(index * 40.sp,
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.ease));
                            }
                            bloc.add(ChangeIndexSliderImageEvent(index));
                          }),
                    )
                  : const SizedBox()),
          widget.listImage.length > 1
              ? _countUI(widget.opacity)
              : const SizedBox()
        ]),
        widget.hasSub
            ? SizedBox(
                height: 50.sp,
                width: (widget.listImage.length * 40).sp + 12.sp,
                child: ListView.builder(
                    itemCount: widget.listImage.length,
                    controller: _scrollSub,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(5.sp),
                    itemBuilder: (context, index) => BlocBuilder(
                        bloc: bloc,
                        buildWhen: (oldState, newState) =>
                            newState is ChangeIndexSliderImageState,
                        builder: (context, state) {
                          final item = ImageFromNetwork(widget.listImage[index],
                              width: 40.sp,
                              height: 40.sp,
                              defaultAsset:
                                  'assets/images/theme2/ic_transparent.png');
                          int blocIndex = 0;
                          if (state is ChangeIndexSliderImageState)
                            blocIndex = state.index;
                          if (index == blocIndex)
                            return Container(
                                child: item,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color: SmartHomeStyle.colorDarkBlue)));
                          return item;
                        })))
            : const SizedBox()
      ]);

  Widget _countUI(double opacity) => widget.showCount
      ? Container(
          margin: EdgeInsets.all(8.sp),
          padding: EdgeInsets.fromLTRB(6.sp, 2.sp, 6.sp, 2.sp),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: BorderRadius.circular(14.sp),
          ),
          child: BlocBuilder(
              bloc: bloc,
              buildWhen: (oldState, newState) =>
                  newState is ChangeIndexSliderImageState,
              builder: (context, state) {
                int blocIndex = 0;
                if (state is ChangeIndexSliderImageState)
                  blocIndex = state.index;
                return TextCustom('${blocIndex + 1}/${widget.listImage.length}',
                    size: 12.sp, color: const Color(0xFFAEA8A8));
              }))
      : Container(
          height: (widget.height ?? 0.3.sh) - 0.2.sw - 20.sp - widget.bottom,
          width: 10.sp,
          margin: EdgeInsets.fromLTRB(20.sp, 20.sp, 20.sp, widget.bottom),
          child: ListView.builder(
              controller: _scroll,
              padding: EdgeInsets.zero,
              itemCount: widget.listImage.length,
              itemBuilder: (context, index) => BlocBuilder(
                  bloc: bloc,
                  buildWhen: (oldState, newState) =>
                      newState is ChangeIndexSliderImageState,
                  builder: (context, state) {
                    int blocIndex = 0;
                    if (state is ChangeIndexSliderImageState)
                      blocIndex = state.index;
                    return Container(
                        width: 10.sp,
                        height: 10.sp,
                        margin: EdgeInsets.only(bottom: 5.sp),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp),
                            color: index == blocIndex
                                ? widget.colorPoint
                                : SmartHomeStyle.primaryColor));
                  })));
}

class ChangeIndexSliderImageState extends BaseState {
  final int index;

  const ChangeIndexSliderImageState(this.index);
}

class ChangeIndexSliderImageEvent extends BaseEvent {
  final int index;

  const ChangeIndexSliderImageEvent(this.index);
}

class ShowLogoState extends BaseState {
  final bool value;

  const ShowLogoState(this.value);
}

class ShowLogoEvent extends BaseEvent {
  final bool value;

  const ShowLogoEvent(this.value);
}

class SliderImageBloc extends BaseBloc {
  SliderImageBloc(
      {ChangeIndexSliderImageState init = const ChangeIndexSliderImageState(0)})
      : super(init: init) {
    on<ChangeIndexSliderImageEvent>((event, emit) {
      emit(ChangeIndexSliderImageState(event.index));
    });
    on<ShowLogoEvent>((event, emit) {
      emit(ShowLogoState(event.value));
    });
  }
}
