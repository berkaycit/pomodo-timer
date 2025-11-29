# Product Requirements Document (PRD)
# Pomodo Timer

**Versiyon:** 1.0
**Tarih:** 29 Kasım 2025
**Platform:** macOS
**Durum:** İlk Sürüm Planlaması

---

## 1. Özet (Executive Summary)

Pomodo Timer, macOS için özel olarak tasarlanmış, performans odaklı bir Pomodoro zamanlayıcı uygulamasıdır. Ekranın üst kısmında notch büyüklüğünde ince bir şerit olarak duran uygulama, kullanıcının tüm gün boyunca zaman yönetimini kolaylaştırırken sistem kaynaklarına neredeyse hiç yük bindirmez.

**Ana Değer Önerisi:**
- Ekranda her zaman görünür, minimal tasarım
- Uzun saatler açık kalsa bile CPU ve RAM'e yük bindirmeyen ultra hafif yapı
- Basit ve odaklanmış kullanıcı deneyimi

---

## 2. Ürüne Genel Bakış

### 2.1 Ürün Tanımı

**Ad:** Pomodo Timer
**Kategori:** Zaman Yönetimi / Verimlilik
**Platform:** macOS (minimum sürüm: TBD)

### 2.2 Ürün Vizyonu

Uzun süreli odaklanma gerektiren profesyoneller için, sistem kaynaklarını tüketmeyen, her zaman erişilebilir bir Pomodoro zamanlayıcısı.

### 2.3 Temel Özellikler

- Ekranın üst kısmında sabit, ince bir bar UI
- 25/45 dakikalık preset süre seçenekleri
- Başlat/Duraklat/Devam ettir kontrolleri
- Süre bitiminde net durum gösterimi
- Tüm uygulamalar ve Space'ler üzerinde görünürlük

---

## 3. Hedefler ve Amaçlar

### 3.1 İş Hedefleri

1. macOS kullanıcıları için hafif ve güvenilir bir Pomodoro çözümü sunmak
2. Performans konusunda rakiplerden açık farkla öne çıkmak
3. Minimal ama etkili bir kullanıcı deneyimi oluşturmak

### 3.2 Kullanıcı Hedefleri

1. Ağır uygulamalar çalışırken bile sorunsuz zaman takibi yapabilmek
2. Dikkat dağıtmadan, her zaman kalan süreyi görebilmek
3. Hızlı ve kolay timer kontrolü yapabilmek

### 3.3 Teknik Hedefler

1. **CPU Kullanımı:** Normal durumda %1'in altında
2. **RAM Kullanımı:** Minimal (örn: <50 MB)
3. **Başlangıç Süresi:** <1 saniye
4. **Stabilite:** 24+ saat kesintisiz çalışabilme, memory leak olmadan

---

## 4. Kullanıcı Profilleri (User Personas)

### Persona 1: Yazılım Geliştirici (Berkay)
- **Yaş:** 25-35
- **Kullanım:** VSCode, Docker, browser ile 8-10 saat çalışıyor
- **İhtiyaç:** CPU/RAM'i yormayan, her Space'te görünür timer
- **Motivasyon:** Odaklanma döngüleri için disiplinli zaman yönetimi

### Persona 2: Tasarımcı (Ayşe)
- **Yaş:** 28-40
- **Kullanım:** Figma, Photoshop, Illustrator gibi ağır uygulamalar
- **İhtiyaç:** Görsel olarak minimal, dikkat dağıtmayan timer
- **Motivasyon:** Proje deadline'larını tutmak için süre takibi

### Persona 3: Öğrenci (Mehmet)
- **Yaş:** 18-25
- **Kullanım:** Ders çalışırken browser, PDF okuyucu, not uygulamaları
- **İhtiyaç:** Basit, tek tuşla kontrol edilebilir timer
- **Motivasyon:** Çalışma seanslarını düzenlemek

---

## 5. Kullanıcı Hikayeleri (User Stories)

### US-001: Timer Başlatma
**Kullanıcı olarak**, varsayılan 25 dakikalık timer'ı tek tıkla başlatabilmek istiyorum, **böylece** hızlıca odaklanma seansına başlayabileyim.

**Kabul Kriterleri:**
- Uygulama açıldığında varsayılan süre 25 dakikadır
- Play butonu görünür durumdadır
- Play butonuna tıklandığında geri sayım başlar

### US-002: Süreyi Görüntüleme
**Kullanıcı olarak**, herhangi bir uygulamada çalışırken kalan süreyi ekranın üst kısmında görebilmek istiyorum, **böylece** dikkatimi dağıtmadan süreyi takip edebileyim.

**Kabul Kriterleri:**
- Timer bar tüm uygulamaların üzerinde görünür
- Süre MM:SS formatında gösterilir
- Her saniye güncellenme yapılır

### US-003: Timer Duraklatma ve Devam Ettirme
**Kullanıcı olarak**, beklenmedik durumlarda timer'ı duraklatıp daha sonra kaldığı yerden devam ettirebilmek istiyorum.

**Kabul Kriterleri:**
- Running durumunda Pause butonu görünür
- Pause'a basıldığında süre dondurulur
- Paused durumunda Resume/Play butonu görünür
- Resume'a basıldığında kalan süreden devam eder

### US-004: Preset Değiştirme
**Kullanıcı olarak**, timer duraklatılmışken veya idle durumundayken 25/45 dakikalık preset'ler arasında geçiş yapabilmek istiyorum.

**Kabul Kriterleri:**
- Timer running değilse preset değiştirilebilir
- Preset değişince timer seçili süreye resetlenir
- Mevcut preset görsel olarak bellidir

### US-005: Süre Bitimi Bildirimi
**Kullanıcı olarak**, süre bittiğinde net bir şekilde bilgilendirilmek ve kolayca yeni tur başlatabilmek istiyorum.

**Kabul Kriterleri:**
- 00:00'a gelince timer durur
- Timer bar'da "Bitti" durumu gösterilir
- Tek tıkla aynı süreyle yeniden başlatma imkanı sunulur

### US-006: Performans Garantisi
**Kullanıcı olarak**, uygulamanın arka planda çalışırken sistem performansımı etkilememesini istiyorum, **böylece** ağır uygulamalarla rahatça çalışabileyim.

**Kabul Kriterleri:**
- CPU kullanımı idle/running durumda %1'in altında
- RAM kullanımı sabit kalır (memory leak yok)
- 8+ saat kesintisiz çalışabilir

---

## 6. Fonksiyonel Gereksinimler

### 6.1 Süre Yönetimi

#### FR-001: Varsayılan Süre
- Uygulama ilk açıldığında varsayılan süre 25 dakika olmalı
- Kullanıcı tercihine göre varsayılan değer değiştirilebilir (gelecek sürüm)

#### FR-002: Preset Süreleri
- Desteklenen preset'ler: 25 / 45 dakika
- Preset seçimi için UI elementi bulunmalı
- Preset değiştirildiğinde timer otomatik resetlenmeli

#### FR-003: Süre Formatı
- Gösterim formatı: MM:SS (örn: 25:00, 04:37)
- Saniye hassasiyetinde geri sayım

### 6.2 Timer Kontrolleri

#### FR-004: Başlat/Duraklat
- Play butonu ile timer başlatılabilmeli
- Pause butonu ile timer durdurulabilmeli
- Resume/Play butonu ile kaldığı yerden devam ettirilebilmeli
- Buton durumları context'e göre değişmeli

#### FR-005: Reset Fonksiyonu (İsteğe Bağlı)
- Timer dururken reset butonu ile seçili preset'e dönülebilmeli
- Running durumda reset için onay istenebilir (UX kararı)

### 6.3 Durum Yönetimi

#### FR-006: Timer Durumları
Timer şu durumlardan birinde olmalı:
1. **Idle (Hazır):** Preset süre gösterilir, Play butonu aktif
2. **Running (Çalışıyor):** Geri sayım aktif, Pause butonu görünür
3. **Paused (Duraklatılmış):** Süre dondurulmuş, Resume butonu görünür
4. **Finished (Bitti):** 00:00 gösterilir, "Bitti" mesajı ve yeniden başlat seçeneği

#### FR-007: Süre Bitimi Davranışı
- Timer 00:00'a ulaştığında otomatik durmalı
- "Finished" durumu UI'da net gösterilmeli
- Kullanıcı tek adımda aynı preset ile yeni tur başlatabilmeli

### 6.4 Görünürlük ve Konum

#### FR-008: Ekran Konumu
- Uygulama penceresi ekranın üst kısmında, ortalanmış konumda
- Notch büyüklüğünde ince bir bar (yükseklik: minimal)
- Genişlik: ~150-300px arası

#### FR-009: Always-on-Top
- Timer bar her zaman diğer pencerelerin üzerinde görünür
- Tüm Space'lerde (virtual desktop'larda) görünür kalır
- Full-screen uygulamalarda bile erişilebilir (macOS API'sine bağlı)

---

## 7. Non-Fonksiyonel Gereksinimler

### 7.1 Performans Gereksinimleri

#### NFR-001: CPU Kullanımı
- **Normal durum (idle/running):** <0.5% CPU
- **Target:** <0.1% CPU
- **Maksimum kabul edilebilir:** %1

**Test Yöntemi:** Activity Monitor ile 1 saat boyunca izleme

#### NFR-002: Bellek Kullanımı
- **Başlangıç:** <30 MB RAM
- **8 saat sonra:** Başlangıç değerinden +%10'dan az artış
- **Memory leak:** Kabul edilemez

**Test Yöntemi:** Instruments ile memory profiling, 24 saat stress test

#### NFR-003: Tick Performansı
- Her saniye yalnızca bir tick işlemi
- UI güncellemesi minimal (sadece değişen text)
- Ağır animasyon, efekt kullanımı yok

#### NFR-004: Başlangıç Süresi
- Uygulamanın açılıp timer bar'ın görünmesi: <1 saniye
- Ağ bağlantısı gerektirmez
- Ağır initialization işlemi yapılmaz

### 7.2 Güvenilirlik

#### NFR-005: Stabilite
- 24+ saat kesintisiz çalışabilme
- Timer drift (saniye kayması) olmamalı
- Crash rate: <0.01%

#### NFR-006: Doğruluk
- Süre hesaplamasında ±1 saniye hata payı (1 saat çalışma için)
- Duraklatma/devam ettirme işlemlerinde süre kaybı olmamalı

### 7.3 Kullanılabilirlik

#### NFR-007: Minimal Öğrenme Eğrisi
- Uygulama açıldığında 5 saniye içinde kullanım anlaşılabilir olmalı
- Tooltip veya help dökümanına gerek duyulmadan kullanılabilir

#### NFR-008: Görsel Minimal İzm
- Dikkat dağıtıcı renkler, animasyonlar kullanılmaz
- macOS native design language'ına uygun olmalı
- Dark/Light mode desteği (sistem ile otomatik uyumlu)

### 7.4 Uyumluluk

#### NFR-009: macOS Sürüm Desteği
- Minimum: macOS 12 (Monterey) veya 13 (Ventura) TBD
- Target: macOS 14 (Sonoma) ve 15 (Sequoia)
- M1/M2/M3 Apple Silicon ve Intel desteklenir

#### NFR-010: Çoklu Monitör Desteği
- Birden fazla ekranda primary screen'de görünür
- Ekran konfigürasyonu değişince pozisyon korunur

---

## 8. Teknik Gereksinimler

### 8.1 Teknoloji Seçimleri

#### TR-001: Programlama Dili
- **Öneri:** Swift (native macOS, performans optimal)
- **Alternatif:** SwiftUI ile UI, native timer mekanizmaları

**Rationale:** Electron, web teknolojileri gibi ağır framework'lerden kaçınmak kritik

#### TR-002: UI Framework
- SwiftUI veya AppKit (performans karşılaştırması yapılacak)
- Native macOS bileşenleri kullanılacak

#### TR-003: Timer Mekanizması
- `Timer.scheduledTimer` veya `DispatchSourceTimer` kullanılacak
- 1 saniye interval, tolerance optimize edilecek
- Background'da da doğru çalışmalı (power efficiency)

### 8.2 Mimari Kararlar

#### TR-004: State Management
- Basit state machine: Idle → Running → Paused → Finished
- Minimal boilerplate, gereksiz abstraction yok

#### TR-005: Veri Saklama
- İlk sürümde: UserDefaults (sadece son preset seçimi vs.)
- Ağır database/storage katmanı yok

#### TR-006: Process Önceliği
- Background'da energy efficiency modu aktif
- Gereksiz CPU wake-up'larından kaçınma

---

## 9. UI/UX Gereksinimleri

### 9.1 Görsel Tasarım

#### UX-001: Timer Bar Boyutları
- **Yükseklik:** ~30-40px (notch boyutuna yakın, test edilecek)
- **Genişlik:** 150-300px (içerik boyutuna göre dinamik olabilir)
- **Corner radius:** macOS standartlarına uygun (yuvarlatılmış köşeler)

#### UX-002: Tipografi
- Süre gösterimi: SF Mono veya SF Pro (monospace preferred)
- Font size: Okunabilir, ama minimal (~14-16pt)
- Font weight: Medium veya Semibold

#### UX-003: Renk Paleti
- **Light mode:** Beyaz/açık gri bar, koyu text
- **Dark mode:** Koyu gri bar, açık text
- **Vurgu rengi:** Sistem accent color veya minimal custom (örn: turuncu/yeşil)
- **Finished state:** Vurgu rengi ile belirtme (örn: yeşil border)

### 9.2 Etkileşim Tasarımı

#### UX-004: Hover/Click States
- Butonlar üzerine gelindiğinde subtle hover efekti
- Click feedback minimal (scale/opacity değişimi)
- Animasyon süresi: 150-200ms (eğer varsa)

#### UX-005: Preset Seçimi UI
- Segmented control veya button group
- 25 / 45 dakika seçenekleri açıkça görünür
- Seçili preset belirgin (bold/highlight)

#### UX-006: Bitti Durumu UI
- "00:00" gösterilir
- "Bitti" veya "✓" ikonu (minimal)
- Play butonu → "Yeniden Başlat" veya direkt play ile yeni tur
- Opsiyonel: Subtle color pulse (yeşil/turuncu - performans etkilemeyecek şekilde)

### 9.3 Erişilebilirlik

#### UX-007: VoiceOver Desteği
- Tüm butonlar için descriptive label
- Timer durumu VoiceOver ile okunabilir

#### UX-008: Klavye Kısayolları (Gelecek Sürüm)
- Space: Play/Pause toggle
- R: Reset
- 1/2/3: Preset seçimi

---

## 10. Başarı Metrikleri

### 10.1 Performans Metrikleri
- **CPU kullanımı:** <0.5% (target), <1% (max)
- **RAM kullanımı:** <50 MB
- **Başlangıç süresi:** <1 saniye
- **24 saat stabilite:** Crash yok, memory leak yok

### 10.2 Kullanıcı Deneyimi Metrikleri
- **İlk kullanım süresi:** <5 saniye (anlaşılır kullanım)
- **Günlük ortalama kullanım süresi:** 4+ saat (hedef kullanıcı profili için)

### 10.3 Test Kriterleri
| Metrik | Hedef | Ölçüm Yöntemi |
|--------|-------|---------------|
| CPU (idle) | <0.1% | Activity Monitor, 1 saat |
| CPU (running) | <0.5% | Activity Monitor, 1 saat |
| RAM başlangıç | <30 MB | Activity Monitor |
| RAM 8 saat sonra | <35 MB | Instruments, memory profiling |
| Başlangıç süresi | <1 sn | Manuel test, 10 deneme ortalaması |
| Timer doğruluk | ±1 sn/saat | Karşılaştırmalı test (sistem saati) |
| 24 saat stabilite | Crash yok | Automated overnight test |

---

## 11. Kapsam Dışı (Out of Scope - v1.0)

Aşağıdaki özellikler ilk sürüme dahil **DEĞİLDİR**, gelecek versiyonlarda değerlendirilebilir:

1. **Sesli Bildirim / Alarm:** Performans etkisi değerlendirilmeli
2. **Custom Süreler:** İlk sürümde sadece 25/45 dk preset'leri
3. **İstatistikler / Geçmiş:** Veri saklama ve UI yükü
4. **Pomodoro Sayacı:** Kaç tur tamamlandığı tracking
5. **Uzun/Kısa Mola Sistemi:** Klasik Pomodoro tekniğinin tam implementasyonu
6. **Break Timer:** Mola süreleri için ayrı timer
7. **Klavye Kısayolları:** Nice-to-have, ama v1.0'da zorunlu değil
8. **Menu Bar Entegrasyonu:** Sadece üst bar yeterli
9. **Notification Center Bildirimi:** Sistem notification'ları ekstra yük
10. **Cloud Sync / Hesap Sistemi:** Tamamen lokal uygulama
11. **Tema Özelleştirme:** Sistem dark/light mode yeterli
12. **Animasyonlu Progress Bar:** Performans için static gösterim

---

## 12. Geliştirme Planı

### 12.1 Faz 1: Temel Altyapı (Hafta 1-2)
- [ ] Xcode proje setup
- [ ] Pencere yönetimi: Always-on-top, pozisyon, boyut
- [ ] Basit timer mantığı: Start/Pause/Reset
- [ ] State machine implementasyonu
- [ ] Performans profiling baseline

### 12.2 Faz 2: UI Geliştirme (Hafta 2-3)
- [ ] Timer bar UI tasarımı (SwiftUI/AppKit)
- [ ] Preset seçici UI
- [ ] Play/Pause buton states
- [ ] Finished state UI
- [ ] Dark/Light mode desteği

### 12.3 Faz 3: Optimizasyon (Hafta 3-4)
- [ ] CPU kullanımı optimizasyonu
- [ ] RAM kullanımı analizi ve düzeltme
- [ ] Timer tick optimizasyonu (tolerance, drift fix)
- [ ] Gereksiz re-render'ların önlenmesi
- [ ] Başlangıç süresi optimizasyonu

### 12.4 Faz 4: Test ve Stabilite (Hafta 4-5)
- [ ] Unit testler (timer logic)
- [ ] UI testleri (state transitions)
- [ ] 24 saat stabilite testi
- [ ] Performans benchmark'ları
- [ ] Çoklu monitör test
- [ ] Space geçişleri test

### 12.5 Faz 5: Polish ve Release (Hafta 5-6)
- [ ] UX iyileştirmeleri (feedback'e göre)
- [ ] Icon/asset tasarımı
- [ ] App bundle ve code signing
- [ ] İlk kullanıcı test grubu (5-10 kişi)
- [ ] Bug fix ve iterasyon
- [ ] v1.0 Release

---

## 13. Riskler ve Azaltma Stratejileri

### 13.1 Risk: macOS API Kısıtlamaları
**Açıklama:** Always-on-top davranışı veya Space'ler arası görünürlük beklendiği gibi çalışmayabilir.

**Azaltma:**
- Erken aşamada pencere yönetimi testleri
- Apple dökümanları ve forum araştırması
- Alternatif implementasyon yöntemleri hazır bulundurma

### 13.2 Risk: Performans Hedeflerine Ulaşamama
**Açıklama:** Timer tick'leri veya UI update'leri hedeflenen %1 CPU limitini aşabilir.

**Azaltma:**
- Her geliştirme adımında Instruments ile profiling
- Erken optimizasyon yapma (trade-off: doğru yerden başlama)
- Alternatif timer mekanizmaları test etme (DispatchSourceTimer vs Timer)

### 13.3 Risk: Timer Drift (Saniye Kayması)
**Açıklama:** Uzun süreli kullanımda timer'ın gerçek zamandan sapması.

**Azaltma:**
- Absolute time tracking kullanımı (relative değil)
- Test süitine drift detection ekleme
- Saatlik otomatik düzeltme mekanizması (gerekirse)

### 13.4 Risk: Kullanıcı Kabulü
**Açıklama:** Minimal UI kullanıcılar tarafından "çok basit" bulunabilir.

**Azaltma:**
- Erken kullanıcı testleri
- Feedback döngüsü ile iterasyon
- "Minimal = güçlü" mesajlaşması (marketing)

---

## 14. Gelecek Versiyonlar İçin Düşünceler

### v1.1 Potansiyel Özellikler
- Klavye kısayolları
- Custom süre girişi (preset'lere ek olarak)
- Basit sesli bildirim (performans etkisi kabul edilebilirse)
- Menu bar item (opsiyonel görünürlük)

### v1.2+ Potansiyel Özellikler
- Pomodoro tur sayacı
- Uzun/kısa mola sistemi
- Basit istatistikler (günlük/haftalık tur sayısı)
- Export/import ayarlar

### Uzun Vadeli Fikirler
- iOS/iPadOS companion app (sync ile)
- Fokus modları ile entegrasyon (macOS Focus)
- Calendar entegrasyonu (toplantı süresince auto-pause)

---

## 15. Ekler

### 15.1 Referanslar
- Apple Human Interface Guidelines: [https://developer.apple.com/design/human-interface-guidelines/macos](https://developer.apple.com/design/human-interface-guidelines/macos)
- Pomodoro Technique: [https://francescocirillo.com/pages/pomodoro-technique](https://francescocirillo.com/pages/pomodoro-technique)

### 15.2 Terminoloji
- **Preset:** Önceden tanımlanmış süre seçeneği (25/45 dk)
- **Timer Bar:** Ekranın üst kısmında görünen uygulama penceresi
- **Tick:** Timer'ın her saniye tetiklenen güncelleme döngüsü
- **Drift:** Timer'ın gerçek zamandan sapma miktarı
- **Always-on-top:** Diğer tüm pencerelerin üzerinde görünme davranışı
- **Space:** macOS virtual desktop

### 15.3 Sürüm Geçmişi
| Versiyon | Tarih | Değişiklikler |
|----------|-------|---------------|
| 1.0 | 29 Kasım 2025 | İlk PRD oluşturuldu |

---

## 16. Onay ve İletişim

**Proje Sahibi:** [İsim]
**Geliştirici:** [İsim]
**Tasarımcı:** [İsim - eğer varsa]

**Onay Durumu:** ☐ Taslak | ☐ Review'de | ☐ Onaylandı

---

**Son Güncelleme:** 29 Kasım 2025
