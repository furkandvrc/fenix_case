# TMDB Movie App

Bu uygulama, TMDB (The Movie Database) API'sini kullanarak film aramayı ve favori filmleri yönetmeyi sağlayan bir Flutter uygulamasıdır.

## Özellikler

- 🎬 Popüler filmleri görüntüleme
- 🔍 Film arama
- ❤️ Favori filmleri yerel olarak kaydetme
- 📱 Responsive tasarım
- ♾️ Sonsuz scroll ile sayfalama
- 🎨 Modern ve kullanıcı dostu arayüz

## Teknik Özellikler

### Mimari
- Clean Architecture prensiplerine uygun yapı
- Repository pattern kullanımı
- GetX state management
- Dependency injection

### Kullanılan Teknolojiler
- Flutter
- GetX (State Management)
- Dio (HTTP Client)
- SharedPreferences (Yerel Depolama)
- CachedNetworkImage (Görsel Önbellekleme)

### Proje Yapısı

```
lib/
  ├── core/
  │   ├── constants/
  │   └── network/
  ├── data/
  │   ├── models/
  │   └── repositories/
  ├── domain/
  │   ├── entities/
  │   └── repositories/
  └── presentation/
      ├── controllers/
      ├── screens/
      └── widgets/
```

## Kurulum

1. Projeyi klonlayın:
```bash
git clone https://github.com/YOUR_USERNAME/fenix_case.git
```

2. Bağımlılıkları yükleyin:
```bash
flutter pub get
```

3. Uygulamayı çalıştırın:
```bash
flutter run
```

## Ekran Görüntüleri

[Ekran görüntüleri buraya eklenecek]

## API Kullanımı

Uygulama TMDB API'sini kullanmaktadır. Kullanılan endpoint'ler:

- Popüler Filmler: `/movie/top_rated`
- Film Arama: `/search/movie`
- Film Detayları: `/movie/{movie_id}`

## Geliştirici

Furkan Divarcı

## Lisans

Bu proje MIT lisansı altında lisanslanmıştır.
