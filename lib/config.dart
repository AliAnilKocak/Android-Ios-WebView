

class CustomConfig {
  static const String title = "WebView App"; // Uygulamanın başlık kısmı
  static const String splashImage = "flutter_icon.png"; // Splash Ekranda görüntülenecek resim.(Resim dosyanızı assets klasörünün içine atmanız gerekmektedir.)
  static const lang = Language.tr; 
  static  get getUrl{
      if(lang == Language.tr){
        return "https://oitheblog.com/"; //Türkçe olacaksa
      }else{
        return "https://oitheblog.com/en"; // İngilizce olacaksa
      }
  }

}

enum Language {
  tr, en
}
