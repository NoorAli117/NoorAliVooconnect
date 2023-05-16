//
//  SoundViewBlocState.swift
//  Vooconnect
//
//  Created by JV on 25/02/23.
//

import Foundation
import SwiftUIBloc
//enum SoundsViewBlocState2: StateBase{
//    static func == (lhs: SoundsViewBlocState2, rhs: SoundsViewBlocState2) -> Bool {
//        false
//    }
//    case searchSongList([DeezerSongModel])
//    case favoriteSongList([DeezerSongModel])
//}

/// This is the sounds bloc state, use this struct to store all variables and data the bloc needs
/// - parameter:
///     - searchSongList: the result of calling deezer api
///     - filterSongList: the result of the `searchSongList` with filter
///     - favoriteSongList: saved songs, use api to stored
///     - preview: `DeezerSongModel` preview to play audio
///     - typeSoundFilter: type of filter applied, result stored on `filterSongList`
///     - query: the current search query sended to Deezer API ``DeezerApiManager``
struct SoundsViewBlocState: StateBase{
    static func == (lhs: SoundsViewBlocState, rhs: SoundsViewBlocState) -> Bool {
        false
    }
    var searchSongList = [DeezerSongModel]()
    var filterSongList = [DeezerSongModel]()
    var favoriteSongList = [DeezerSongModel]()
    var fastSearchSongList = [DeezerSongModel]()
    var preview : DeezerSongModel? = nil
    var typeSoundsFilter = TypeOfSoundFilter.all
    var query = ""
}

//class SoundsViewBlocState3: StateBase {
//    var id = UUID()
//    var preview : DeezerSongModel?
//    var searchSongList = [DeezerSongModel]()
//    var favoriteSongList = [DeezerSongModel]()
//
//
//    static func == (lhs: SoundsViewBlocState3, rhs: SoundsViewBlocState3) -> Bool {
//        lhs.id == rhs.id
//    }
////    func copy(with zone: NSZone? = nil) -> Any {
////        let copy = SoundsViewBlocState(id: id, preview: preview)
////        return copy
////    }
////    func copyWith(preview: DeezerSongModel? = nil, searchSongList) -> SoundsViewBlocState {
////        let copy = SoundsViewBlocState(id: id, preview: preview ?? self.preview)
////        return copy
////    }
//    init(id: UUID = UUID(), preview: DeezerSongModel? = nil, searchSongList : [DeezerSongModel] = [], favoriteSongList : [DeezerSongModel] = []) {
//        self.id = id
//        self.preview = preview
//    }
//
//    func setSearchSongList(list: [DeezerSongModel])
//    {
//        self.searchSongList = list
//    }
//}
