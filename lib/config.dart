

class CustomConfig {
  static const String title = "Deep Score App"; // Uygulamanın başlık kısmı
  static const String splashImage = "flutter_icon.png"; // Splash Ekranda görüntülenecek resim.(Resim dosyanızı assets klasörünün içine atmanız gerekmektedir.)
  static const lang = Language.tr; 
  static  get getUrl{
      if(lang == Language.tr){
        return "https://app.deepscoreapp.com/tr/"; //Türkçe olacaksa
      }else{
        return "https://app.deepscoreapp.com/"; // İngilizce olacaksa
      }
  }

}

enum Language {
  tr, en
}
