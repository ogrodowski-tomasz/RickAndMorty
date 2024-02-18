import Foundation

protocol CharactersListServiceManagerProtocol {
    func getCharactersList(page: Int) async throws -> [SingleCharacter]
}

enum APIError: Error {
    case missingURL
    case missingResponse
    case invalidStatusCode(code: Int)
    case decoding(Error)
}

final class CharactersListServiceManager: Network.CharacterList {
    func getCharactersList(page: Int) async throws -> [SingleCharacter] {
        guard let url = RickAndMortyEndpoint.charactersList(page: page).url else {
            throw APIError.missingURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.missingResponse
        }

        guard (200...399) ~= httpResponse.statusCode  else {
            throw APIError.invalidStatusCode(code: httpResponse.statusCode)
        }
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(CharacterListResponseModel.self, from: data)
            return decodedData.results
        } catch {
            throw APIError.decoding(error)
        }
    }


}

final class CharactersListServiceManagerStub: Network.CharacterList {
    func getCharactersList(page: Int) async throws -> [SingleCharacter] {
        try await Task.sleep(nanoseconds: 5_000_000_000)
        let results = try StaticJsonMapper.fetch(filename: "CharacterListStaticData", decodeToType: CharacterListResponseModel.self)
        return results.results
    }
}
