import 'dart:io';
import 'dart:math' as math;
import 'dart:ui';

import 'package:car_3d_card_list/src/models/car_model.dart';
import 'package:flutter/material.dart';

/// 3D 자동차 카드 위젯
class CarCard extends StatefulWidget {
  const CarCard({
    super.key,
    required this.car,
    this.onTap,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.linearToEaseOut,
  });

  /// 자동차 모델
  final CarModel car;

  /// 카드 클릭 시 호출되는 콜백
  final VoidCallback? onTap;

  /// 카드 애니메이션 지속 시간
  final Duration duration;

  /// 카드 애니메이션 곡선
  final Curve curve;

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  /// 카드의 모서리 둥글기
  final _borderRadius = BorderRadius.circular(20);

  /// 호버 시 카드 크기 증가량
  final _hoverScaleIncrement = 0.12;

  Size _size = Size.zero;
  Offset _centerOffset = Offset.zero;

  bool _isHovered = false;
  Offset _pointerOffset = Offset.zero;

  /// 자동차 대표 이미지
  File get _image => widget.car.images.first;

  /// 자동차 로고
  File get _logo => widget.car.logo;

  /// 연식
  int get _year => widget.car.year;

  /// 자동차 풀네임
  String get _name => widget.car.name;

  /// 카드의 그림자 효과
  /// 포인터 호버 여부에 따라 그림자 크기와 흐림 정도가 달라지고 포인터 위치에 따라 오프셋이 달라진다.
  List<BoxShadow> get _resolvedBoxShadow {
    final offsetScaleFactor = 0.06;
    final spreadRadius = _isHovered ? 8.0 : 3.0;
    final blurRadius = _isHovered ? 30.0 : 10.0;
    final shadowOffset =
        _isHovered
            ? (_centerOffset - _pointerOffset) * offsetScaleFactor
            : Offset.zero;

    return [
      BoxShadow(
        color: Colors.grey.shade800,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        offset: shadowOffset,
      ),
    ];
  }

  /// 포인터 호버 여부에 따른 카드 크기 스케일 값
  double get _resolvedScale => 1.0 + (_isHovered ? _hoverScaleIncrement : 0);

  /// 포인터 호버 여부에 따른 카드 변환 Matrix4 행렬
  /// 카드의 3D 회전 효과를 위해 사용하며 회전값은 포인터 위치에 따라 달라짐
  Matrix4 get _resolvedTransform {
    final matrix4 = Matrix4.identity()..setEntry(3, 2, 0.001);

    if (_isHovered) {
      // 최대 회전 각도를 8으로 설정한 tan 값
      final angle = math.tan(math.pi * 8 / 180);
      final dx = _centerOffset.dx - _pointerOffset.dx;
      final dy = _centerOffset.dy - _pointerOffset.dy;

      matrix4.rotateY(-dx / _centerOffset.dx * angle);
      matrix4.rotateX(dy / _centerOffset.dy * angle);
    }
    return matrix4;
  }

  /// 포인터 감지 영역 확장을 위한 패딩 값
  EdgeInsets get _resolvedPadding =>
      EdgeInsets.symmetric(
        horizontal: _centerOffset.dx,
        vertical: _centerOffset.dy,
      ) *
      _hoverScaleIncrement;

  void _startHover() {
    setState(() => _isHovered = true);
  }

  void _stopHover() {
    setState(() => _isHovered = false);
  }

  void _updatePointerOffset(Offset offset) {
    // 모바일 지원을 위한 오프셋 범위 제한
    offset = Offset(
      clampDouble(offset.dx, 0, _size.width),
      clampDouble(offset.dy, 0, _size.height),
    );

    setState(() => _pointerOffset = offset);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _size = context.size!;

      setState(() {
        _centerOffset = Offset(_size.width / 2, _size.height / 2);
      });
    });
  }

  /// 카드 유지하기 위해 사용
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final fadeInDuration = Duration(milliseconds: 700);

    return AnimatedSlide(
      duration: fadeInDuration,
      curve: Curves.easeOutSine,
      offset: _centerOffset == Offset.zero ? Offset(0, 0.2) : Offset.zero,
      child: AnimatedOpacity(
        duration: fadeInDuration,
        opacity: _centerOffset == Offset.zero ? 0 : 1,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildShadow(),
            _build3DImage(),
            _buildCarInfo(),
            _buildPointerArea(),
          ],
        ),
      ),
    );
  }

  /// 카드 그림자
  Widget _buildShadow() {
    if (_centerOffset == Offset.zero) {
      return const SizedBox();
    }

    return AnimatedContainer(
      duration: widget.duration,
      curve: widget.curve,
      margin: _resolvedPadding,
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        boxShadow: _resolvedBoxShadow,
      ),
    );
  }

  /// 자동차 이미지
  Widget _build3DImage() {
    return Padding(
      padding: _resolvedPadding,
      child: Transform(
        transform: _resolvedTransform,
        alignment: Alignment.center,
        child: AnimatedScale(
          duration: widget.duration,
          curve: widget.curve,
          scale: _resolvedScale,
          child: AnimatedContainer(
            duration: widget.duration,
            curve: widget.curve,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(borderRadius: _borderRadius),
            foregroundDecoration: BoxDecoration(
              borderRadius: _borderRadius,
              color: !_isHovered ? Colors.black38 : null,
            ),
            child: Hero(
              tag: _image.path,
              child: ClipRRect(
                borderRadius: _borderRadius,
                child: Image.asset(_image.path, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 포인터 감지 영역
  Widget _buildPointerArea() {
    return Padding(
      padding: !_isHovered ? _resolvedPadding : EdgeInsets.zero,
      child: ClipRRect(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: _borderRadius,
        child: GestureDetector(
          onTap: widget.onTap,
          onPanStart: (details) => _startHover(),
          onPanUpdate: (details) => _updatePointerOffset(details.localPosition),
          onPanEnd: (details) => _stopHover(),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (event) => _startHover(),
            onExit: (event) => _stopHover(),
            onHover: (event) => _updatePointerOffset(event.localPosition),
          ),
        ),
      ),
    );
  }

  /// 자동차 정보
  Widget _buildCarInfo() {
    Widget logo() {
      final logo = Image.asset(_logo.path, width: _size.width * 0.08);

      return Stack(
        children: [
          Transform.translate(
            offset: Offset(2, 2),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black54,
                  BlendMode.srcATop,
                ),
                child: logo,
              ),
            ),
          ),
          logo,
        ],
      );
    }

    Widget text() {
      return Expanded(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            shadows: [
              Shadow(
                color: Colors.black,
                offset: const Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$_year'),
              Text(
                _name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
    }

    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: _resolvedPadding,
        child: AnimatedSize(
          duration: widget.duration,
          curve: widget.curve,
          alignment: Alignment.bottomLeft,
          child: SizedBox(
            height: _isHovered ? _size.width * 0.09 : 0,
            width: _size.width,
            child: Row(children: [logo(), SizedBox(width: 10), text()]),
          ),
        ),
      ),
    );
  }
}
