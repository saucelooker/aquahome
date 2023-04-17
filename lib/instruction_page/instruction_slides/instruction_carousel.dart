import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../generated/l10n.dart';
import '../../style/theme_colors.dart';
import 'instruction_card.dart';

class InstructionCarousel extends StatefulWidget {
  final void Function() onConnection;

  const InstructionCarousel({Key? key, required this.onConnection})
      : super(key: key);

  @override
  State<InstructionCarousel> createState() => _InstructionCarouselState();
}

class _InstructionCarouselState extends State<InstructionCarousel> {
  final controller = CarouselController();
  int activeIndex = 0;
  Curve curve = Curves.easeInOutSine;
  Duration duration = const Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = Theme.of(context).extension<ThemeColors>()!;
    final localization = S.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
            carouselController: controller,
            items: [
              InstructionCard().setCard(
                  context,
                  localization.instructionPageWiFi,
                  'assets/images/connect_to_wifi_image.png',
                  218,
                  localization.instructionPageWiFiDesc,
                  confirmButtonName: localization.next,
                  cancelButtonName: localization.skip,
                  onCancel: () => widget.onConnection(),
                  onConfirm: () =>
                      controller.nextPage(duration: duration, curve: curve)),
              InstructionCard().setCard(
                  context,
                  localization.instructionPagePower,
                  'assets/images/connect_to_power_image.png',
                  251,
                  localization.instructionPagePowerDesc,
                  confirmButtonName: localization.next,
                  cancelButtonName: localization.back,
                  onCancel: () =>
                      controller.previousPage(duration: duration, curve: curve),
                  onConfirm: () =>
                      controller.nextPage(duration: duration, curve: curve)),
              InstructionCard().setCard(
                context,
                localization.instructionPageReset,
                'assets/images/reset_image.png',
                189,
                localization.instructionPageResetDesc,
                confirmButtonName: localization.connect,
                cancelButtonName: localization.back,
                onCancel: () =>
                    controller.previousPage(duration: duration, curve: curve),
                onConfirm: () => widget.onConnection(),
              ),
            ],
            options: CarouselOptions(
                initialPage: 0,
                height: 474,
                enableInfiniteScroll: false,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() => activeIndex = index);
                })),
        SizedBox(
          height: 24,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: 3,
              effect: ScrollingDotsEffect(
                  dotHeight: 6,
                  dotWidth: 6,
                  activeDotColor: themeColors.primaryTextColor,
                  dotColor: themeColors.secondaryTextColor),
            ),
          ),
        )
      ],
    );
  }
}
