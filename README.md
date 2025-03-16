# TMDB Movie App

TMDB API kullanılarak geliştirilmiş, film arama ve favori yönetimi yapabileceğiniz modern bir Flutter uygulaması.

## Özellikler

- 🎬 Popüler filmleri görüntüleme
- 🔍 Film arama
- ❤️ Favori filmleri yerel olarak kaydetme
- 📱 Responsive tasarım
- ♾️ Sonsuz kaydırma (Infinite scroll)
- 🎯 Modern UI/UX

## Ekran Görüntüleri

<div style="display: flex; justify-content: space-between;">
  <img src="assets/Simulator Screenshot - iPhone 16 Pro - 2025-03-16 at 20.09.33.png" width="250" alt="Ana Ekran"/>
  <img src="assets/Simulator Screenshot - iPhone 16 Pro - 2025-03-16 at 20.09.36.png" width="250" alt="Film Detay"/>
  <img src="assets/Simulator Screenshot - iPhone 16 Pro - 2025-03-16 at 20.09.39.png" width="250" alt="Favoriler"/>
</div>

## Teknik Özellikler

### Mimari
- Clean Architecture prensipleri
- Repository pattern
- GetX state management
- Dependency injection

### Kullanılan Teknolojiler

- Flutter
- GetX (State Management)
- Dio (HTTP Client)
- SharedPreferences (Yerel Depolama)
- CachedNetworkImage (Görsel Önbellekleme)

## Proje Yapısı

```
lib/
├── core/                   # Çekirdek fonksiyonlar ve utility'ler
├── data/                   # Data katmanı
│   ├── models/            # Data modelleri
│   └── repositories/      # Repository implementasyonları
├── domain/                # Domain katmanı
│   ├── entities/          # Domain entity'leri
│   └── repositories/      # Repository interface'leri
└── presentation/          # Sunum katmanı
    ├── controllers/       # GetX controllers
    ├── screens/           # Ekranlar
    └── widgets/           # Yeniden kullanılabilir widget'lar
```

## Kurulum

1. Repository'yi klonlayın:
```bash
git clone https://github.com/furkandvrc/fenix_case.git
```

2. Bağımlılıkları yükleyin:
```bash
flutter pub get
```

3. Uygulamayı çalıştırın:
```bash
flutter run
```

## API Kullanımı

Bu uygulama TMDB API'sini kullanmaktadır. Aşağıdaki endpoint'ler kullanılmıştır:

- `/movie/popular` - Popüler filmleri listeler
- `/search/movie` - Film araması yapar

## Geliştirici

Furkan Divarcı

## Lisans

Bu proje MIT lisansı altında lisanslanmıştır.
