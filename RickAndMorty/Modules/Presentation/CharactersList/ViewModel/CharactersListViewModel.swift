import Foundation

enum CharacterListViewState: Equatable {
    case unloaded
    case loading
    case loaded([SingleCharacter])
    case error(Error)

    static func == (lhs: CharacterListViewState, rhs: CharacterListViewState) -> Bool {
        switch (lhs, rhs) {
        case (.unloaded, .unloaded):
            return true
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return true
        case (.error, .error):
            return true
        default:
            return false
        }
    }
}

final class CharactersListViewModel: ObservableObject {
    
    // MARK: - PUBLIC PROPERTIES
    @Published private(set) var viewState: CharacterListViewState = .unloaded

    // MARK: - PRIVATE PROPERTIES
    private let storageManager: Persistence.CharacterList

    // MARK: - INIT
    init(storageManager: Persistence.CharacterList) {
        self.storageManager = storageManager
    }

    // MARK: - PUBLIC METHODS
    func setState(_ viewState: CharacterListViewState) {
        self.viewState = viewState
    }

    func getCharacters() {
        viewState = .loading
        Task {
            do {
                let fetched = try await storageManager.getCharactersList(page: 1)
                DispatchQueue.main.async { [weak self] in
                    self?.viewState = .loaded(fetched)
                }
            } catch let error {
                viewState = .error(error)
            }
        }
    }

    // MARK: - PRIVATE METHODS
}
