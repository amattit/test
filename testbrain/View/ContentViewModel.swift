//
//  ContentViewModel.swift
//  testbrain
//
//  Created by 16997598 on 22.10.2020.
//  Copyright © 2020 Mikhail Seregin. All rights reserved.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var moments: [MomentResponse] = []
    
    let repository = Repository()
    var store = Set<AnyCancellable>()
    
    func auth() {
        self.repository.auth()
                .map { $0 }
                .sink(receiveCompletion: check(_:)) { resp in
                    UserDefaults.standard.set(resp.sessionToken, forKey: .sessionKey)
                    UserDefaults.standard.set(resp.objectId, forKey: .userId)
                    self.getMoments()
            }
        .store(in: &store)
    }
    
    func getMoments() {
        self.repository.fetchMoments()
                .map { $0 }
                .sink(receiveCompletion: check(_:)) { resp in
                    self.moments = resp.results
            }
        .store(in: &store)
    }
    
    func deleteMoment(_ moment: MomentResponse) {
        self.repository.deleteMoment(id: moment.objectID).map { $0 }
            .sink(receiveCompletion: check(_:)) { (_) in
                self.getMoments()
        }.store(in: &store)
    }
    
    func check(_ result: Subscribers.Completion<Error>) {
        switch result {
        case .failure(let error):
            print(error.localizedDescription)
        default:
            break
        }
    }
}
