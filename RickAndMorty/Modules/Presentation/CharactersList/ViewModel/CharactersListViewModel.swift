import Foundation

final class CharactersListViewModel: ObservableObject {
    
    // MARK: - PUBLIC PROPERTIES
    @Published private(set) var characters = [SingleCharacter]()
    @Published private(set) var error: APIError? = nil

    // MARK: - PRIVATE PROPERTIES
    private let storageManager: Persistence.CharacterList

    // MARK: - INIT
    init(storageManager: Persistence.CharacterList) {
        self.storageManager = storageManager
        Task {
            await getCharacters()
        }
    }

    // MARK: - PUBLIC METHODS


    // MARK: - PRIVATE METHODS

    private func getCharacters() async {
        do {
            let fetched = try await storageManager.getCharactersList(page: 1)
            DispatchQueue.main.async { [weak self] in
                self?.characters = fetched
            }
        } catch let error {
            fatalError("Error: \(error)")
        }
    }

}
