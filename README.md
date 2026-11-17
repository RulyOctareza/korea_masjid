<p align="center">
  <img src="docs/preview/hero.png" alt="Korea Masjid — ilustrasi aplikasi pencari masjid" width="100%">
</p>

<h1 align="center">Korea Masjid</h1>

<p align="center">
  <b>Temukan masjid Indonesia di Korea Selatan.</b><br>
  Peta · jarak terdekat · favorit · berbagi
</p>

<p align="center">
  <a href="https://flutter.dev"><img alt="Flutter" src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white"></a>
  <img alt="BLoC" src="https://img.shields.io/badge/State-BLoC%20(Cubit)-2496ED">
  <a href="https://firebase.google.com"><img alt="Firebase" src="https://img.shields.io/badge/Backend-Firebase-FFCA28?logo=firebase&logoColor=black"></a>
</p>

---

## ✨ Preview

<p align="center">
  <img src="docs/preview/hero.png" alt="Mockup gelap Korea Masjid" width="90%">
</p>

> **Catatan:** gambar di atas adalah *ilustrasi konsep*, bukan screenshot asli.

---

## 📖 Tentang

Aplikasi pencari masjid untuk muslim Indonesia di Korea Selatan. Data masjid diambil dari
Cloud Firestore, lengkap dengan kartu jarak terdekat, galeri, dan tombol berbagi.

---

## 🌟 Fitur

- 🕌 **Daftar & detail masjid** dengan galeri foto
- 📏 **Kartu masjid terdekat** (`masjid_terdekat`, `masjid_distance_card`)
- 🔎 **Pencarian**
- ⭐ **Favorit**
- 👥 **Komunitas masjid**
- 📰 **Blog**
- 📤 **Berbagi** via `share_plus`
- 🌐 **Build web** (Firebase Hosting / Vercel)

---

## 🛠️ Tech Stack

| Area | Pilihan |
|---|---|
| Framework | Flutter (Android, iOS, Web) |
| State management | BLoC / Cubit |
| Data | Cloud Firestore + Firebase Auth |
| HTTP | `http` |
| Analitik web | Vercel Analytics (`@vercel/analytics`) |

---

## 🚀 Menjalankan

```bash
flutter pub get
flutter run
```

Untuk web:

```bash
flutter build web
```

Konfigurasi Firebase mengikuti `firebase_options.dart`.
