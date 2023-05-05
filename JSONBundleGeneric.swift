extension Bundle {
    /*
        "Bundle" adlı sınıfı genişletme (extension) yaparak "decode" adlı bir fonksiyon oluşturuyoruz.
        decode adlı işlev, dosya adını (file) ve çözümlenecek nesne türünü (T) parametre olarak alır. 
        T parametresi, Codable protokolünü uygulayan herhangi bir tür olabilir.
    */
    func decode<T: Codable>(_ file: String) -> T {
        // Belirtilen dosyanın URL'sini al.
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Bundle içinde \(file) dosyası bulunamadı.")
        }

        // Dosya içeriğini yükle.
        guard let data = try? Data(contentsOf: url) else {
            fatalError("\(file) dosyası yüklenemedi.")
        }

        // JSONDecoder kullanarak dosyayı çöz.
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("\(file) dosyası JSONDecoder ile çözümlenemedi.")
        }

        // Çözümlenmiş dosyayı geri döndür.
        return loaded
    }
}


// Kullanımı 1. Alternatif
let books = Bundle.main.decode<Book>("book.json") 
// Kullanımı 2. Alternatif
let books: [Book] = Bundle.main.decode("books.json")





