# Çözcük iOS

Bu proje, Çözcük oyununun iOS arayüzüdür. Oyunun ana projesine ve sunucu dosyalarına  [Çözcük Server](https://github.com/keremkoseoglu/cozcuk-server) projesi üzerinden erişebilirsiniz.

Kodlama; doğrudan Swift ile XCode üzerinde yapılmıştır.

## Özellikler

Proje kapsamında, aşağıdaki özellikler uygulanmıştır:
- Oyun ekranı
- Kullanıcı bilgileri
- Yeni kullanıcı kaydetme
- "Şifremi unuttum"
- Facebook üzerinden OAuth

## Proje yapısı

### /Cozcuk

Burada, uygulamanın ana dosyaları yer almaktadir
- **FirstViewController.swift**: Oyun ekranı
- **ForgotPassword.swift**: Yeni şifre talebi
- **SecondViewController.swift**: Kullanıcı ayarları
- **Configuration.swift**: Kullanıcı ayarlarının kaydedilmesinden sorumludur
- **Http.swift**: HTTP Post, Get gibi yöntemlerden sorumludur
- **User.swift**: Yeni kullanıcı kaydı
- **Gui.swift**: Arayüz ile ilgili yordamlar barındırır

### /Pods

Dışarıdan yüklenmiş Facebook kütüphaneleri ile ilgili dosyaları içerir.
