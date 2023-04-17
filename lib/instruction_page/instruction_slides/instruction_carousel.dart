import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
            carouselController: controller,
            items: [
              InstructionCard().setCard(
                  context,
                  'Убедитесь, что Ваш телефон подключен в wi-fi сети.',
                  'assets/images/connect_to_wifi_image.png',
                  218,
                  'Подключаемый модуль будет работать в wi-fi сети, к которой Ваш телефон подключен в текущий момент и к которой у Вас есть доступ.',
                  confirmButtonName: 'Далее',
                  cancelButtonName: 'Пропустить',
                  onCancel: () => widget.onConnection(),
                  onConfirm: () =>
                      controller.nextPage(duration: duration, curve: curve)),
              InstructionCard().setCard(
                  context,
                  'Подключите модуль к сети питания.',
                  'assets/images/connect_to_power_image.png',
                  251,
                  'Если модулей несколько, то производить подключение необходимо строго по-одному.',
                  confirmButtonName: 'Далее',
                  cancelButtonName: 'Назад',
                  onCancel: () =>
                      controller.previousPage(duration: duration, curve: curve),
                  onConfirm: () =>
                      controller.nextPage(duration: duration, curve: curve)),
              InstructionCard().setCard(
                context,
                'Удерживайте кнопку «Reset» в течение 2 секунд.',
                'assets/images/reset_image.png',
                189,
                'В режиме подключения световой индикатор начнёт мигать жёлтым цветом.',
                confirmButtonName: 'Подключить',
                cancelButtonName: 'Назад',
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
