extension Bundle {
    // "Bundle" adlı sınıfı genişletme (extension) yaparak "decode" adlı bir fonksiyon oluşturuyoruz.
    func decode(_ file: String) -> [String: Astronaut] {
        // "url" adlı bir değişkene, "file" parametresinin adını belirterek uygulamanın ana bundle'ındaki JSON dosyasının URL'sini atıyoruz.
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        // "data" adlı bir değişkene, "url" değişkenindeki URL'den JSON dosyasının içeriğini yüklüyoruz.
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        // "decoder" adlı bir değişkene JSONDecoder sınıfını kullanarak bir JSON çözücü nesnesi oluşturuyoruz.
        let decoder = JSONDecoder()

        // "loaded" adlı bir değişkene "data" değişkenindeki JSON verilerini çözümleyerek [String: Astronaut] türündeki bir sözlüğe atıyoruz.
        guard let loaded = try? decoder.decode([String: Astronaut].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        // "loaded" sözlüğünü geri döndürüyoruz.
        return loaded
    }
}
