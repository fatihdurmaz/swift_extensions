extension Bundle {
    /// Bir dosyayı yükler ve verilen türde çözümler.
    ///
    /// - Parameters:
    ///   - file: Yüklenecek dosyanın adı.
    /// - Returns: Yüklenmiş dosyanın verilen türdeki temsilcisi.
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

// Kullanımı

let book = Bundle.main.decode<Book>("book.json")



