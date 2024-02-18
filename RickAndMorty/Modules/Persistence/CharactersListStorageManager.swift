import Foundation

protocol CharactersListStorageManagerProtocol {
    func getCharactersList(page: Int) async throws -> [SingleCharacter]
}

final class CharactersListStorageManager: Persistence.CharacterList {

    // MARK: - PRIVATE PROPERTIES
    private let networkManager: Network.CharacterList

    // MARK: - INIT
    init(networkManager: Network.CharacterList) {
        self.networkManager = networkManager
    }

    // MARK: PUBLIC METHODS
    func getCharactersList(page: Int) async throws -> [SingleCharacter] {
        let fetchedCharacters = try await networkManager.getCharactersList(page: page)
        return fetchedCharacters
    }
    

}
