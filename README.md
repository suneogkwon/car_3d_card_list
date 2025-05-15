# 3D 자동차 카드 갤러리

![Flutter](https://img.shields.io/badge/Flutter-3.7+-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

사용자 인터페이스 효과와 3D 애니메이션을 사용한 애플리케이션입니다.

## 📱 주요 기능

- **입체적인 3D 카드 효과**: 마우스나 터치의 위치에 따라 카드가 3D로 회전하고 변형됩니다.
- **동적 그림자**: 포인터 위치에 따라 실시간으로 변화하는 그림자 효과를 제공합니다.
- **플로팅 텍스트**: 카드의 입체감을 더하는 텍스트 효과를 제공합니다.
- **상세 페이지**: 각 자동차 모델의 다양한 각도에서 촬영된 이미지와 상세 정보를 제공합니다.
- **반응형 디자인**: 다양한 화면 크기에 최적화된 사용자 경험을 제공합니다.

## 🚀 사용된 기술

- **Flutter**: 크로스 플랫폼 UI 개발을 위한 프레임워크
- **Matrix4 변환**: 사실적인 3D 회전 및 원근감 효과 구현
- **Hero 애니메이션**: 화면 전환 시 부드러운 공유 요소 애니메이션
- **반응형 프레임워크**: 다양한 화면 크기에 대응
- **커스텀 제스처 처리**: 포인터 위치에 따른 3D 효과 계산

## 📚 사용된 패키지

- `responsive_framework`: 반응형 UI 구현
- `flutter_screenutil`: 화면 크기에 맞는 일관된 UI 요소 크기 조정

## 🔧 설치 및 실행

1. 이 리포지토리를 클론합니다:
   ```bash
   git clone https://github.com/yourusername/car_3d_card_list.git
   ```

2. 의존성 패키지를 설치합니다:
   ```bash
   flutter pub get
   ```

3. 애플리케이션을 실행합니다:
   ```bash
   flutter run
   ```

## 🧰 프로젝트 구조

```
lib/
├── generated/
│   └── assets.dart              # 자동 생성된 에셋 경로 상수
├── main.dart                    # 앱 진입점
├── src/
│   ├── app.dart                 # 앱 설정 및 테마
│   ├── models/
│   │   └── car_model.dart       # 자동차 데이터 모델
│   ├── screens/
│   │   ├── car_detail_screen.dart  # 자동차 상세 화면
│   │   └── card_list_screen.dart   # 자동차 카드 목록 화면
│   ├── utils/
│   │   ├── media_query_util.dart   # 미디어 쿼리 유틸리티
│   │   └── responsive_util.dart    # 반응형 유틸리티
│   └── widgets/
│       └── car_card.dart        # 3D 자동차 카드 위젯
│
assets/
├── images/                      # 자동차 이미지
│   ├── Audi-RS7-*.webp
│   ├── BMW-X5-MCompetition-*.webp
│   ├── Lamborghini-Urus-SE-*.webp
│   ├── Mercedes-G-Class-*.webp
│   └── Porsche-Cayenne-Coupe-*.webp
└── logo/                        # 브랜드 로고
    ├── Audi.png
    ├── BMW.png
    ├── Benz.png
    ├── Lamborghini.png
    └── Porsche.png
```

### 주요 컴포넌트 설명

#### 모델 (Models)
- **CarModel**: 자동차 정보를 담는 데이터 클래스로, 이미지, 로고, 브랜드, 모델명을 포함합니다.

#### 화면 (Screens)
- **CarListScreen**: 자동차 카드 목록을 그리드 형태로 보여주는 메인 화면입니다. 반응형 레이아웃을 지원합니다.
- **CarDetailScreen**: 선택한 자동차의 상세 정보와 이미지를 보여주는 화면입니다.

#### 위젯 (Widgets)
- **CarCard**: 핵심 UI 컴포넌트로, 포인터 위치에 따라 3D로 회전하는 자동차 카드를 구현합니다. Matrix4 변환을 사용하여 입체감을 표현하고, 동적 그림자 효과를 제공합니다.

#### 유틸리티 (Utils)
- **MediaQueryUtil**: 화면 크기 관련 유틸리티 확장 함수를 제공합니다.
- **ResponsiveUtil**: 반응형 브레이크포인트 관련 유틸리티 확장 함수를 제공합니다.

## 📋 고도화(TODO) 리스트

- [ ] **성능 최적화**: 대용량 이미지 로딩 시 메모리 관리 및 렌더링 성능 개선
- [ ] **라이트 모드 지원**: 시스템 테마에 맞는 다크 모드 및 라이트 모드 전환 기능 구현
- [ ] **자동차 데이터 API 연동**: 원격 서버에서 자동차 정보를 가져오는 API 서비스 통합
- [ ] **즐겨찾기 기능**: 사용자가 관심 있는 자동차를 즐겨찾기에 추가하고 관리할 수 있는 기능 구현
- [ ] **검색 및 필터링**: 브랜드, 모델명, 가격대 등으로 자동차를 검색하고 필터링하는 기능 추가
