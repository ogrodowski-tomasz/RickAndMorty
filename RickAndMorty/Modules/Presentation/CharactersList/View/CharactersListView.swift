import SwiftUI

struct CharactersListView: View {
    @ObservedObject var viewModel: CharactersListViewModel
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .unloaded:
                unloadedViewState()
            case .loading:
                loadingViewState()
            case .loaded(let characterList):
                loadedViewState(characterList)
            case .error(let error):
                errorViewState(error)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Remove") {
                    viewModel.setState(.unloaded)
                }
                .opacity(viewModel.viewState != .unloaded ? 1 : 0 )
            }
        }
    }

    private func unloadedViewState() -> some View {
        VStack {
            Text("No data. Fetch it now!")
            Button {
                viewModel.getCharacters()
            } label: {
                Text("Click here to load data!")
                    .foregroundStyle(.white)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                    }
            }
        }
    }

    private func loadingViewState() -> some View {
        ProgressView()
    }

    private func loadedViewState(_ charactersList: [SingleCharacter]) -> some View {
        List(charactersList) { character in
            Text(character.name)
        }
    }

    private func errorViewState(_ error: Error) -> some View {
        VStack {
            Text("OH NO! Error happened!")
            Text(error.localizedDescription)
        }
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView(viewModel: characterListViewModel())
    }
}

